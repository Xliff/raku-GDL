use v6.c;

use Method::Also;

use GDL::Raw::Types;
use GDL::Raw::Layout;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdlDockLayoutAncestry is export of Mu
  where GdlDockLayout | GObject;

class GDL::Layout {
  also does GLib::Roles::Object;

  has GdlDockLayout $!gdl is implementor;

  submethod BUILD ( :$dock-layout ) {
    self.setGdlDockLayout($dock-layout) if $dock-layout
  }

  method setGdlDockLayout (GdlDockLayoutAncestry $_) {
    my $to-parent;

    $!gdl = do {
      when GdlDockLayout {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdlDockLayout, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDL::Raw::Structs::GdlDockLayout
    is also<GdlDockLayout>
  { $!gdl }

  multi method new (
     $dock-layout where * ~~ GdlDockLayoutAncestry,
    :$ref                                            = True
  ) {
    return unless $dock-layout;

    my $o = self.bless( :$dock-layout );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdlDockObject() $master) {
    my $dock-layout = gdl_dock_layout_new($master);

    $dock-layout ?? self.bless( :$dock-layout ) !! Nil;
  }

  # Type: boolean
  method dirty is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('dirty', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'dirty does not allow writing'
      }
    );
  }

  # Type: GdlObject
  method master ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDL::Manager.getTypePair );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('master', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDL::Master.getTypePair
        );
      },
      STORE => -> $, GdlDockObject() $val is copy {
        $gv.object = $val;
        self.prop_set('master', $gv);
      }
    );
  }

  method attach (GdlDockMaster() $master) {
    gdl_dock_layout_attach($!gdl, $master);
  }

  method delete_layout (Str() $name) is also<delete-layout> {
    gdl_dock_layout_delete_layout($!gdl, $name);
  }

  method get_layouts (Int() $include_default) is also<get-layouts> {
    my gboolean $i = $include_default.so.Int;

    gdl_dock_layout_get_layouts($!gdl, $i);
  }

  method get_master ( :$raw = False ) is also<get-master> {
    propReturnObject(
      gdl_dock_layout_get_master($!gdl),
      $raw,
      |GDL::Master.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    gdl_dock_layout_get_type();
  }

  method is_dirty is also<is-dirty> {
    so gdl_dock_layout_is_dirty($!gdl);
  }

  method load_from_file (Str() $filename) is also<load-from-file> {
    gdl_dock_layout_load_from_file($!gdl, $filename);
  }

  method load_layout (Str() $name) is also<load-layout> {
    gdl_dock_layout_load_layout($!gdl, $name);
  }

  method save_layout (Str() $name) is also<save-layout> {
    gdl_dock_layout_save_layout($!gdl, $name);
  }

  method save_to_file (Str() $filename) is also<save-to-file> {
    gdl_dock_layout_save_to_file($!gdl, $filename);
  }

  method set_master (GObject() $master) is also<set-master> {
    gdl_dock_layout_set_master($!gdl, $master);
  }

}
