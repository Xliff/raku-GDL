use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use GTK::Raw::Structs;
use GDL::Raw::Definitions;
use GDL::Raw::Enums;
use GDL::Raw::Structs;

unit package GDL::Raw::Object;

### /usr/src/gdl/gdl/gdl-dock-item.h

sub gdl_dock_item_bind (
  GdlDockItem $item,
  GtkWidget   $dock
)
  is      native(gdl)
  is      export
{ * }

# sub gdl_dock_item_class_set_has_grip (
#   GdlDockItemClass $item_class,
#   gboolean         $has_grip
# )
#   is      native(gdl)
#   is      export
# { * }

sub gdl_dock_item_dock_to (
  GdlDockItem      $item,
  GdlDockItem      $target,
  GdlDockPlacement $position,
  gint             $docking_param
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_get_behavior_flags (GdlDockItem $item)
  returns GdlDockItemBehavior
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_get_child (GdlDockItem $item)
  returns GtkWidget
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_get_drag_area (
  GdlDockItem  $item,
  GdkRectangle $rect
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_get_grip (GdlDockItem $item)
  returns GtkWidget
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_get_orientation (GdlDockItem $item)
  returns GtkOrientation
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_get_tablabel (GdlDockItem $item)
  returns GtkWidget
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_hide_grip (GdlDockItem $item)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_hide_item (GdlDockItem $item)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_iconify_item (GdlDockItem $item)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_is_closed (GdlDockItem $item)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_is_iconified (GdlDockItem $item)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_is_placeholder (GdlDockItem $item)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_lock (GdlDockItem $item)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_new (
  Str                 $name,
  Str                 $long_name,
  GdlDockItemBehavior $behavior
)
  returns GtkWidget
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_new_with_pixbuf_icon (
  Str                 $name,
  Str                 $long_name,
  GdkPixbuf           $pixbuf_icon,
  GdlDockItemBehavior $behavior
)
  returns GtkWidget
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_new_with_stock (
  Str                 $name,
  Str                 $long_name,
  Str                 $stock_id,
  GdlDockItemBehavior $behavior
)
  returns GtkWidget
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_notify_deselected (GdlDockItem $item)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_notify_selected (GdlDockItem $item)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_or_child_has_focus (GdlDockItem $item)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_preferred_size (
  GdlDockItem    $item,
  GtkRequisition $req
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_set_behavior_flags (
  GdlDockItem         $item,
  GdlDockItemBehavior $behavior,
  gboolean            $clear
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_set_child (
  GdlDockItem $item,
  GtkWidget   $child
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_set_default_position (
  GdlDockItem   $item,
  GdlDockObject $reference
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_set_orientation (
  GdlDockItem    $item,
  GtkOrientation $orientation
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_set_tablabel (
  GdlDockItem $item,
  GtkWidget   $tablabel
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_show_grip (GdlDockItem $item)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_show_item (GdlDockItem $item)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_unbind (GdlDockItem $item)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_unlock (GdlDockItem $item)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_unset_behavior_flags (
  GdlDockItem         $item,
  GdlDockItemBehavior $behavior
)
  is      native(gdl)
  is      export
{ * }
