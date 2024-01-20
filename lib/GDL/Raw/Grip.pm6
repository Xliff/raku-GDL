use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GDK::Raw::Structs;
use GTK::Raw::Definitions;
use GDL::Raw::Definitions;
use GDL::Raw::Structs;

unit package GDL::Raw::Grip;

### /usr/src/gdl/gdl/gdl-dock-item-grip.h

sub gdl_dock_item_grip_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_grip_has_event (
  GdlDockItemGrip $grip,
  GdkEvent        $event
)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_grip_hide_handle (GdlDockItemGrip $grip)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_grip_new (GdlDockItem $item)
  returns GtkWidget
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_grip_set_cursor (
  GdlDockItemGrip $grip,
  gboolean        $in_drag
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_grip_set_label (
  GdlDockItemGrip $grip,
  GtkWidget       $label
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_item_grip_show_handle (GdlDockItemGrip $grip)
  is      native(gdl)
  is      export
{ * }
