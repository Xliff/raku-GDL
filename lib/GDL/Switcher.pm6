use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GDL::Raw::Types;
use GTK::Enums;

use GLib::Roles::Implementor;

class GDL::Switcher {
  has GdlSwitcher $!gs is implementor;

  method new {
    my $dock-switcher = gdl_switcher_new();

    $dock-switcher ?? self.bless( :$dock-switcher ) !! Nil;
  }

  # Type: GdlSwitcherStyle
  method switcher-style ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GDL::Enum::SwitcherStyle.get_type );
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

  # Type: GdlPositionType
  method tab-pos ( :$enum = True ) is rw  is g-property {
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
  method tab-reorderable is rw  is g-property {
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

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdl_switcher_get_type, $n, $t );
  }

  method insert_page (
    GtkWidget   $page,
    GtkWidget   $tab_widget,
    Str         $label,
    Str         $tooltips,
    Str         $stock_id,
    GdkPixbuf   $pixbuf_icon,
    gint        $position
  ) {
    gdl_switcher_insert_page($!gs, $page, $tab_widget, $label, $tooltips, $stock_id, $pixbuf_icon, $position);
  }

}

### /usr/src/gdl/gdl/gdl-switcher.h

sub gdl_switcher_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_switcher_insert_page (
  GdlSwitcher $switcher,
  GtkWidget   $page,
  GtkWidget   $tab_widget,
  Str         $label,
  Str         $tooltips,
  Str         $stock_id,
  GdkPixbuf   $pixbuf_icon,
  gint        $position
)
  returns gint
  is      native(gdl)
  is      export
{ * }

sub gdl_switcher_new
  returns GdlSwitcher
  is      native(gdl)
  is      export
{ * }
