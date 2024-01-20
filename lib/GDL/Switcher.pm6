use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GDL::Raw::Types;
use GTK::Enums;

use GTK::Notebook;

use GLib::Roles::Implementor;

our subset GdlSwitcherAncestry is export of Mu
  where GdlSwitcher | GtkNotebookAncestry;

class GDL::Switcher is GTK::Notebook {
  has GdlSwitcher $!gs is implementor;

  submethod BUILD ( :$dock-switcher ) {
    self.setGdlSwitcher($dock-switcher) if $dock-switcher
  }

  method setGdlSwitcher (GdlSwitcherAncestry $_) {
    my $to-parent;

    $!gs = do {
      when GdlSwitcher {
        $to-parent = cast(GtkNotebook, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdlSwitcher, $_);
      }
    }
    self.setGtkNotebook($to-parent);
  }

  method GDL::Raw::Definitions::GdlSwitcher
    is also<GdlSwitcher>
  { $!gs }

  multi method new (
     $dock-switcher where * ~~ GdlSwitcherAncestry,
    :$ref                                           = True
  ) {
    return unless $dock-switcher;

    my $o = self.bless( :$dock-switcher );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dock-switcher = gdl_switcher_new();

    $dock-switcher ?? self.bless( :$dock-switcher ) !! Nil;
  }

  # Type: GdlSwitcherStyle
  method switcher-style ( :$enum = True )
    is rw
    is g-property
    is also<switcher_style>
  {
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

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdl_switcher_get_type, $n, $t );
  }

  method insert_page (
    GtkWidget()   $page,
    GtkWidget()   $tab_widget,
    Str()         $label,
    Str()         $tooltips,
    Str()         $stock_id,
    GdkPixbuf()   $pixbuf_icon,
    Int()         $position
  )
    is also<insert-page>
  {
    my gint $p = $position;

    gdl_switcher_insert_page(
      $!gs,
      $page,
      $tab_widget,
      $label,
      $tooltips,
      $stock_id,
      $pixbuf_icon,
      $p
    );
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
