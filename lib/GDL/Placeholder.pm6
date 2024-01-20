use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GDL::Raw::Types;
use GDL::Enums;

use GDL::Object;

use GLib::Roles::Implementor;


our subset GdlDockPlaceholderAncestry is export of Mu
  where GdlDockPlaceholder | GdlDockObjectAncestry;

class GDL::Placeholder is GDL::Object {
  has GdlDockPlaceholder $!gdp is implementor;

  submethod BUILD ( :$gdl-placeholder ) {
    self.setGdlDockPlaceholder($gdl-placeholder) if $gdl-placeholder
  }

  method setGdlDockPlaceholder (GdlDockPlaceholderAncestry $_) {
    my $to-parent;

    $!gdp = do {
      when GdlDockPlaceholder {
        $to-parent = cast(GdlDockObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdlDockPlaceholder, $_);
      }
    }
    self.setGdlDockObject($to-parent);
  }

  method GDL::Raw::Definitions::GdlDockPlaceholder
    is also<GdlDockPlaceholder>
  { $!gdp }

  multi method new (
     $gdl-placeholder where * ~~ GdlDockPlaceholderAncestry,
    :$ref                                                     = True
  ) {
    return unless $gdl-placeholder;

    my $o = self.bless( :$gdl-placeholder );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str()           $name,
    GdlDockObject() $object,
    Int()           $position,
    Int()           $sticky
  ) {
    my GdlDockPlacement $p = $position;
    my gboolean         $s = $sticky;

    my $dock-placeholder = gdl_dock_placeholder_new($name, $object, $p, $s);

    $dock-placeholder ?? self.bless( :$dock-placeholder ) !! Nil;
  }

  # Type: boolean
  method floating is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('floating', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('floating', $gv);
      }
    );
  }

  # Type: int
  method floatx is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('floatx', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('floatx', $gv);
      }
    );
  }

  # Type: int
  method floaty is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('floaty', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('floaty', $gv);
      }
    );
  }

  # Type: int
  method height is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('height', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('height', $gv);
      }
    );
  }

  # Type: GdlDockObject
  method host ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDL::Object.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('host', $gv);
        propReturnObject( $gv.object, $raw, |GDL::Object.getTypePair );
      },
      STORE => -> $, GdlDockObject() $val is copy {
        $gv.object = $val;
        self.prop_set('host', $gv);
      }
    );
  }

  # Type: GdlDockPlacement
  method next-placement ( :$enum = True )
    is rw
    is g-property
    is also<next_placement>
  {
    my $gv = GLib::Value.new( GDL::Enums::DockPlacement.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('next-placement', $gv);
        my $p = $gv.enum;
        return $p unless $enum;
        GdlDockPlacementEnum($p);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GdlDockPlacement) = $val;
        self.prop_set('next-placement', $gv);
      }
    );
  }

  # Type: boolean
  method sticky is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('sticky', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('sticky', $gv);
      }
    );
  }

  # Type: int
  method width is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width', $gv);
      }
    );
  }

  method attach (GdlDockObject() $object) {
    gdl_dock_placeholder_attach($!gdp, $object);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdl_dock_placeholder_get_type, $n, $t );
  }

}

### /usr/src/gdl/gdl/gdl-dock-placeholder.h

sub gdl_dock_placeholder_attach (
  GdlDockPlaceholder $ph,
  GdlDockObject      $object
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_placeholder_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_placeholder_new (
  Str              $name,
  GdlDockObject    $object,
  GdlDockPlacement $position,
  gboolean         $sticky
)
  returns GdlDockPlaceholder
  is      native(gdl)
  is      export
{ * }
