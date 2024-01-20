use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDL::Raw::Types;
use GDL::Raw::Bar;

use GTK::Box;

use GTK::Roles::Orientable;

use GLib::Roles::Implementor;

our subset GdlDockBarAncestry is export of Mu
  where GdlDockBar | GtkBoxAncestry;

class GDL::Bar is GTK::Box {
  also does GTK::Roles::Orientable;

  has GdlDockBar $!gdb is implementor;

  submethod BUILD ( :$dock-bar ) {
    self.setGdlDockBar($dock-bar) if $dock-bar
  }

  method setGdlDockBar (GdlDockBarAncestry $_) {
    my $to-parent;

    $!gdb = do {
      when GdlDockBar {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdlDockBar, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method GDL::Raw::Definitions::GdlDockBar
    is also<GdlDockBar>
  { $!gdb }

  multi method new (
     $dock-bar where * ~~ GdlDockBarAncestry,
    :$ref                                     = True
  ) {
    return unless $dock-bar;

    my $o = self.bless( :$dock-bar );
    $o.ref if $ref;
    $o;
  }
  multi method new (GObject() $master) {
    my $dock-bar = gdl_dock_bar_new($master);

    $dock-bar ?? self.bless( :$dock-bar ) !! Nil;
  }

  # Type: GdlDockBarStyle
  method dockbar-style ( :$enum = True )
    is rw
    is g-property
    is also<dockbar_style>
  {
    my $gv = GLib::Value.new( GDL::Enuns::DockBarStyle.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('dockbar-style', $gv);
        my $s = $gv.enum;
        return $s unless $enum;
        GdlDockBarStyleEnum($s);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GdlDockBarStyle) = $val;
        self.prop_set('dockbar-style', $gv);
      }
    );
  }

  # Type: GdlObject
  method master ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDL::Object.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('master', $gv);
        propReturnObject($gv.object, $raw, |GDL::Object.getTypePair);
      },
      STORE => -> $, GdlDockObject()  $val is copy {
        $gv.object = $val;
        self.prop_set('master', $gv);
      }
    );
  }

  method get_style ( :$enum = True ) is also<get-style> {
    my $s = gdl_dock_bar_get_style($!gdb);
    return $s unless $enum;
    GdlDockBarStyleEnum($s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdl_dock_bar_get_type, $n, $t );
  }

  method set_style (Int() $style) is also<set-style> {
    my GdlDockBarStyle $s = $style;

    gdl_dock_bar_set_style($!gdb, $s);
  }

}
