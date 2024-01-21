use v6.c;

use Method::Also;

use GDL::Raw::Types;
use GDL::Raw::Master;

use GTK::Enums;
use GDL::Object;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdlDockMasterAncestry is export of Mu
  where GdlDockMaster | GObject;

class GDL::Master {
  also does GLib::Roles::Object;

  has GdlDockMaster $!gdm is implementor;

  submethod BUILD ( :$dock-master ) {
    self.setGdlDockMaster($dock-master) if $dock-master
  }

  method setGdlDockMaster (GdlDockMasterAncestry $_) {
    my $to-parent;

    $!gdm = do {
      when GdlDockMaster {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdlDockMaster, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDL::Raw::Structs::GdlDockMaster
    is also<GdlDockMaster>
  { $!gdm }

  multi method new (
     $dock-master where * ~~ GdlDockMasterAncestry,

    :$ref                                           = True
  ) {
    return unless $dock-master;

    my $o = self.bless( :$dock-master );
    $o.ref if $ref;
    $o;
  }

  # Type: string
  method default-title is rw  is g-property is also<default_title> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('default-title', $gv);
      }
    );
  }

  # Type: int
  method locked is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('locked', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('locked', $gv);
      }
    );
  }

  # Type: GdlSwitcherStyle
  method switcher-style ( :$enum = True )
    is rw
    is g-property
    is also<switcher_style>
  {
    my $gv = GLib::Value.new( GDL::Enums::SwitcherStyle.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('switcher-style', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        GdlSwitcherStyleEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GdlSwitcherStyle) = $val;
        self.prop_set('switcher-style', $gv);
      }
    );
  }

  # Type: GtkPositionType
  method tab-pos ( :$enum = True ) is rw  is g-property is also<tab_pos> {
    my $gv = GLib::Value.new( GTK::Enums::Position.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tab-pos', $gv);
        my $p = $gv.enum;
        return $p unless $enum;
        GtkPositionTypeEnum($p);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkPositionType) = $val;
        self.prop_set('tab-pos', $gv);
      }
    );
  }

  # Type: boolean
  method tab-reorderable is rw  is g-property is also<tab_reorderable> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tab-reorderable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('tab-reorderable', $gv);
      }
    );
  }

  method layout-changed is also<layout_changed> {
    self.connect($!gdm, 'layout-changed');
  }

  method add (GdlDockObject $object) {
    gdl_dock_master_add($!gdm, $object);
  }

  method foreach (&function, gpointer $user_data = gpointer) {
    gdl_dock_master_foreach($!gdm, &function, $user_data);
  }

  method foreach_toplevel (
    gboolean $include_controller,
             &function,
    gpointer $user_data           = gpointer
  )
    is also<foreach-toplevel>
  {
    gdl_dock_master_foreach_toplevel(
      $!gdm,
      $include_controller,
      &function,
      $user_data
    );
  }

  method get_controller ( :$raw = False ) is also<get-controller> {
    propReturnObject(
      gdl_dock_master_get_controller($!gdm),
      $raw,
      |GDL::Object.getTypePair
    );
  }

  method get_dock_name is also<get-dock-name> {
    gdl_dock_master_get_dock_name($!gdm);
  }

  method get_object (Str() $nick_name, :$raw = False) is also<get-object> {
    propReturnObject(
      gdl_dock_master_get_object($!gdm, $nick_name),
      $raw,
      |GDL::Object.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdl_dock_master_get_type, $n, $t );
  }

  method remove (GdlDockObject() $object) {
    gdl_dock_master_remove($!gdm, $object);
  }

  method set_controller (GdlDockObject() $new_controller)
    is also<set-controller>
  {
    gdl_dock_master_set_controller($!gdm, $new_controller);
  }

}
