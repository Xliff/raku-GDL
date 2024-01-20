use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Structs;
use GDL::Raw::Definitions;
use GDL::Raw::Enums;
use GDL::Raw::Structs;

unit package GDL::Raw::Dock;

### /usr/src/gdl/gdl/gdl-dock.h

sub gdl_dock_add_floating_item (
  GdlDock     $dock,
  GdlDockItem $item,
  gint        $x,
  gint        $y,
  gint        $width,
  gint        $height
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_add_item (
  GdlDock          $dock,
  GdlDockItem      $item,
  GdlDockPlacement $placement
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_get_item_by_name (
  GdlDock $dock,
  Str     $name
)
  returns GdlDockItem
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_get_named_items (GdlDock $dock)
  returns GList
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_get_placeholder_by_name (
  GdlDock $dock,
  Str     $name
)
  returns GdlDockPlaceholder
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_get_root (GdlDock $dock)
  returns GdlDockObject
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_hide_preview (GdlDock $dock)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_new
  returns GdlDock
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_new_from (
  GdlDock  $original,
  gboolean $floating
)
  returns GdlDock
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_get_toplevel (GdlDockObject $object)
  returns GdlDock
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_set_skip_taskbar (
  GdlDock  $dock,
  gboolean $skip
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_show_preview (
  GdlDock      $dock,
  GdkRectangle $rect
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_xor_rect (
  GdlDock      $dock,
  GdkRectangle $rect
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_xor_rect_hide (GdlDock $dock)
  is      native(gdl)
  is      export
{ * }
