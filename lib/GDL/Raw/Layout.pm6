use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GTK::Raw::Enums;
use GDL::Raw::Definitions;
use GDL::Raw::Structs;

unit package GDL::Raw::Layout;

### /usr/src/gdl/gdl/gdl-dock-layout.h

sub gdl_dock_layout_attach (
  GdlDockLayout $layout,
  GdlDockMaster $master
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_delete_layout (
  GdlDockLayout $layout,
  Str           $name
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_get_layouts (
  GdlDockLayout $layout,
  gboolean      $include_default
)
  returns GList
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_get_master (GdlDockLayout $layout)
  returns GObject
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_is_dirty (GdlDockLayout $layout)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_load_from_file (
  GdlDockLayout $layout,
  Str           $filename
)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_load_layout (
  GdlDockLayout $layout,
  Str           $name
)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_new (GObject $master)
  returns GdlDockLayout
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_save_layout (
  GdlDockLayout $layout,
  Str           $name
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_save_to_file (
  GdlDockLayout $layout,
  Str           $filename
)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_layout_set_master (
  GdlDockLayout $layout,
  GObject       $master
)
  is      native(gdl)
  is      export
{ * }
