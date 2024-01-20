use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDL::Raw::Types;
use GDL::Raw::Item;
use GDL::Enums;

use GTK::Widget;
use GDL::Object;

use GLib::Roles::Implementor;
use GDL::Roles::Signals::Item;

our subset GdlDockItemAncestry is export of Mu
  where GdlDockItem | GdlDockObjectAncestry;

class GDL::Item is GDL::Object {
  has GdlDockItem $!gdi is implementor;

  submethod BUILD ( :$dock-item ) {
    self.setGdlDockItem($dock-item) if $dock-item
  }

  method setGdlDockItem (GdlDockItemAncestry $_) {
    my $to-parent;

    $!gdi = do {
      when GdlDockItem {
        $to-parent = cast(GdlDockObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdlDockItem, $_);
      }
    }
    self.setGdlDockObject($to-parent);
  }

  method GDL::Raw::Definitions::GdlDockItem
    is also<GdlDockItem>
  { $!gdi }

  multi method new (
     $dock-item where * ~~ GdlDockItemAncestry,
    :$ref                                        = True
  ) {
    return unless $dock-item;

    my $o = self.bless( :$dock-item );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name, Str() $long_name, Int() $behavior) {
    my GdlDockItemBehavior $b = $behavior;

    my $gdl-item = gdl_dock_item_new($name, $long_name, $b);

    $gdl-item ?? self.bless( :$gdl-item ) !! Nil;
  }

  method new_with_pixbuf_icon (
    Str()       $name,
    Str()       $long_name,
    GdkPixbuf() $pixbuf_icon,
    Int()       $behavior
  )
    is also<new-with-pixbuf-icon>
  {
    my GdlDockItemBehavior $b = $behavior;

    my $gdl-item = gdl_dock_item_new_with_pixbuf_icon(
      $name,
      $long_name,
      $pixbuf_icon,
      $b
    );

    $gdl-item ?? self.bless( :$gdl-item ) !! Nil;
  }

  method new_with_stock (
    Str() $name,
    Str() $long_name,
    Str() $stock_id,
    Int() $behavior
  )
    is also<new-with-stock>
  {
    my GdlDockItemBehavior $b = $behavior;

    my $gdl-item = gdl_dock_item_new_with_stock(
      $name,
      $long_name,
      $stock_id,
      $b
    );

    $gdl-item ?? self.bless( :$gdl-item ) !! Nil;
  }

  method behavior ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GDL::Enums::Behavior.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('orientation', $gv);
        my $b = $gv.enum;
        return $b unless $enum;
        GdlDockItemBehaviorEnum($b);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GdlDockItemBehavior) = $val;
        self.prop_set('orientation', $gv);
      }
    );
  }

  # Type: boolean
  method closed is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('closed', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('closed', $gv);
      }
    );
  }

  # Type: boolean
  method iconified is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('iconified', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('iconified', $gv);
      }
    );
  }

  # Type: boolean
  method locked is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('locked', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('locked', $gv);
      }
    );
  }

  # Type: GdlOrientation
  method orientation ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkOrientation) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('orientation', $gv);
        my $o = $gv.enum;
        return $o unless $enum;
        GtkOrientationEnum($o);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkOrientation) = $val;
        self.prop_set('orientation', $gv);
      }
    );
  }

  # Type: int
  method preferred-height is rw  is g-property is also<preferred_height> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('preferred-height', $gv);
        $gv.int32;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int32 = $val;
        self.prop_set('preferred-height', $gv);
      }
    );
  }

  # Type: int
  method preferred-width is rw  is g-property is also<preferred_width> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('preferred-width', $gv);
        $gv.int32;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int32 = $val;
        self.prop_set('preferred-width', $gv);
      }
    );
  }

  # Type: boolean
  method resize is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('resize', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('resize', $gv);
      }
    );
  }

  # Is originally:
  # GdlDockItem *item,  gboolean cancelled --> void
  method dock-drag-end is also<dock_drag_end> {
    self.connect-bool($!gdi, 'dock-drag-end');
  }

  # Is originally:
  # GdlDockItem *item --> void
  method dock-drag-begin is also<dock_drag_begin> {
    self.connect($!gdi, 'dock-drag-begin');
  }

  # Is originally:
  # GdlDockItem *item,  GtkDirectionType direction --> void
  method move-focus-child is also<move_focus_child> {
    self.connect-int($!gdi, 'move-focus-child');
  }

  # New for this project: The creation of objects in signal handlers!
  # Is originally:
  # GdlDockItem *item,  GdkDevice *device,  gint x,  gint y --> void
  method dock-drag-motion ( :$raw = False ) is also<dock_drag_motion> {
    self.connect-dock-drag-motion($!gdi, :$raw);
  }

  multi method bind (GtkWidget() $dock) {
    gdl_dock_item_bind($!gdi, $dock);
  }

  method dock_to (
    GdlDockItem() $target,
    Int()         $position,
    Int()         $docking_param
  )
    is also<dock-to>
  {
    my GdlDockPlacement $p = $position;
    my gint             $d = $docking_param;

    gdl_dock_item_dock_to($!gdi, $target, $p, $d);
  }

  method get_behavior_flags ( :flags(:$set) = True )
    is also<get-behavior-flags>
  {
    my $f = gdl_dock_item_get_behavior_flags($!gdi);
    return $f unless $set;
    getFlags(GdlDockItemBehavior, $f);
  }

  method get_child (
    :$raw  = False,
    :$type = GTK::Widget
  )
    is also<get-child>
  {
    propReturnObject(
      gdl_dock_item_get_child($!gdi),
      $raw,
      |$type.getTypePair
    );
  }

  proto method get_drag_area (|)
    is also<get-drag-area>
  { * }

  multi method get_drag_area {
    samewith(GdkRectangle.new);
  }
  multi method get_drag_area (GdkRectangle() $rect) {
    gdl_dock_item_get_drag_area($!gdi, $rect);
    $rect;
  }

  method get_grip (
    :$raw  = False,
    :$type = GTK::Widget
  )
    is also<get-grip>
  {
    propReturnObject(
      gdl_dock_item_get_grip($!gdi),
      $raw,
      |$type.getTypePair
    );
  }

  method get_orientation ( :$enum = True ) is also<get-orientation> {
    my $o = gdl_dock_item_get_orientation($!gdi);
    return $o unless $enum;
    GtkOrientationEnum($o);
  }

  method get_tablabel (
    :$raw  = False,
    :$type = GTK::Widget
  )
    is also<get-tablabel>
  {
    propReturnObject(
      gdl_dock_item_get_tablabel($!gdi),
      $raw,
      |$type.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdl_dock_item_get_type, $n, $t );
  }

  method hide_grip is also<hide-grip> {
    gdl_dock_item_hide_grip($!gdi);
  }

  method hide_item is also<hide-item> {
    gdl_dock_item_hide_item($!gdi);
  }

  method iconify_item is also<iconify-item> {
    gdl_dock_item_iconify_item($!gdi);
  }

  method is_closed is also<is-closed> {
    so gdl_dock_item_is_closed($!gdi);
  }

  method is_iconified is also<is-iconified> {
    so gdl_dock_item_is_iconified($!gdi);
  }

  method is_placeholder is also<is-placeholder> {
    so gdl_dock_item_is_placeholder($!gdi);
  }

  method lock {
    gdl_dock_item_lock($!gdi);
  }

  method notify_deselected is also<notify-deselected> {
    gdl_dock_item_notify_deselected($!gdi);
  }

  method notify_selected is also<notify-selected> {
    gdl_dock_item_notify_selected($!gdi);
  }

  method or_child_has_focus is also<or-child-has-focus> {
    so gdl_dock_item_or_child_has_focus($!gdi);
  }

  method preferred_size (GtkRequisition() $req) is also<preferred-size> {
    gdl_dock_item_preferred_size($!gdi, $req);
  }

  method set_behavior_flags (Int() $behavior, Int() $clear)
    is also<set-behavior-flags>
  {
    my GdlDockItemBehavior $b = $behavior;
    my gboolean            $c = $clear;

    gdl_dock_item_set_behavior_flags($!gdi, $behavior, $c);
  }

  method set_child (GtkWidget() $child) is also<set-child> {
    gdl_dock_item_set_child($!gdi, $child);
  }

  method set_default_position (GdlDockObject() $reference)
    is also<set-default-position>
  {
    gdl_dock_item_set_default_position($!gdi, $reference);
  }

  method set_orientation (GtkOrientation() $orientation)
    is also<set-orientation>
  {
    my GtkOrientation $o = $orientation;

    gdl_dock_item_set_orientation($!gdi, $o);
  }

  method set_tablabel (GtkWidget() $tablabel) is also<set-tablabel> {
    gdl_dock_item_set_tablabel($!gdi, $tablabel);
  }

  method show_grip is also<show-grip> {
    gdl_dock_item_show_grip($!gdi);
  }

  method show_item is also<show-item> {
    gdl_dock_item_show_item($!gdi);
  }

  method unbind {
    gdl_dock_item_unbind($!gdi);
  }

  method unlock {
    gdl_dock_item_unlock($!gdi);
  }

  method unset_behavior_flags (Int() $behavior)
    is also<unset-behavior-flags>
  {
    my GdlDockItemBehavior $b = $behavior;

    gdl_dock_item_unset_behavior_flags($!gdi, $behavior);
  }

}
