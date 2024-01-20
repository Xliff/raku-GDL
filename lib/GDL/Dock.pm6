use v6.c;

use GLib::Raw::Traits;
use GDL::Raw::Types;
use GDL::Raw::Dock;

use GLib::GList;
use GTK::Widget;
use GDL::Object;

use GLib::Roles::Implementor;

class GDL::Dock is GTK::Widget {
  has GdlDock $!gd is implementor;

  method new {
    my $dock = gdl_dock_new();

    $dock ?? self.bless( :$dock ) !! Nil;
  }

  method new_from (GdlDock() $original, Int() $floating) {
    my gboolean $f = $floating.so.Int;

    gdl_dock_new_from($original, $f);
  }

  method default-title is rw  is g-property {
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

  # Type: boolean
  method skip-taskbar is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('skip-taskbar', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('skip-taskbar', $gv);
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

  method layout-changed {
    self.connect($!gd, 'layout-changed');
  }

  method add_floating_item (
    GdlDockItem() $item,
    Int()         $xx,
    Int()         $yy,
    Int()         $width,
    Int()         $height
  ) {
    my gint ($x, $y, $w, $h) = ($xx, $yy, $width, $height);

    gdl_dock_add_floating_item($!gd, $item, $x, $y, $w, $h);
  }

  method add_item (
    GdlDockItem() $item,
    Int()         $placement
  ) {
    my GdlDockPlacement $p = $placement;

    gdl_dock_add_item($!gd, $item, $p);
  }

  method get_item_by_name (Str() $name, :$raw = False) {
    propReturnObject(
      gdl_dock_get_item_by_name($!gd, $name),
      $raw,
      |GDL::Object.getTypePair
    );
  }

  method get_named_items ( :$raw = False, :gslist(:$glist) = False ) {
    returnGList(
      gdl_dock_get_named_items($!gd),
      $raw,
      $glist,
      |GDL::Object.getTypePair
    );
  }

  method get_placeholder_by_name (Str() $name) {
    gdl_dock_get_placeholder_by_name($!gd, $name);
  }

  method get_root ( :$raw = False ) {
    propReturnObject(
      gdl_dock_get_root($!gd),
      $raw,
      |GDL::Object.getTypePair
    )
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdl_dock_get_type, $n, $t );
  }

  method hide_preview {
    gdl_dock_hide_preview($!gd);
  }

  method set_skip_taskbar (Int() $skip) {
    my gboolean $s = $skip.so.Int;

    gdl_dock_set_skip_taskbar($!gd, $s);
  }

  method show_preview (GdkRectangle() $rect) {
    gdl_dock_show_preview($!gd, $rect);
  }

}

role GDL::Roles::Dock::Object {

  method get_toplevel ( :$raw = False ) {
    propReturnObject(
      gdl_dock_object_get_toplevel(self.GdlDockObject),
      $raw,
      |GDL::Dock.getTypePair
    );
  }

}

sub get-object-dock (GDL::Object $o, :$raw = False) is export {
  ($o but GDL::Roles::Dock::Object).get_toplevel( :$raw );
}
