use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GDL::Raw::Definitions;
use GDL::Raw::Enums;
use GDL::Raw::Structs;

unit package GDL::Raw::Object;

### /usr/src/gdl/gdl/gdl-dock-object.h

sub gdl_dock_object_bind (
  GdlDockObject $object,
  GObject       $master
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_child_placement (
  GdlDockObject    $object,
  GdlDockObject    $child,
  GdlDockPlacement $placement
)
  returns uint32
  is      native(gdl)
  is      export
{ * }

# sub gdl_dock_object_class_set_is_compound (
#   GdlDockObjectClass $object_class,
#   gboolean           $is_compound
# )
#   is      native(gdl)
#   is      export
# { * }

sub gdl_dock_object_detach (
  GdlDockObject $object,
  gboolean      $recursive
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_dock (
  GdlDockObject    $object,
  GdlDockObject    $requestor,
  GdlDockPlacement $position,
  GValue           $other_data
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_dock_request (
  GdlDockObject  $object,
  gint           $x,
  gint           $y,
  GdlDockRequest $request
)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_freeze (GdlDockObject $object)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_get_controller (GdlDockObject $object)
  returns GdlDockObject
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_get_long_name (GdlDockObject $object)
  returns Str
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_get_master (GdlDockObject $object)
  returns GObject
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_get_name (GdlDockObject $object)
  returns Str
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_get_parent_object (GdlDockObject $object)
  returns GdlDockObject
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_get_pixbuf (GdlDockObject $object)
  returns GdkPixbuf
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_get_stock_id (GdlDockObject $object)
  returns Str
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_is_automatic (GdlDockObject $object)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_is_bound (GdlDockObject $object)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_is_closed (GdlDockObject $object)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_is_compound (GdlDockObject $object)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_is_frozen (GdlDockObject $object)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_layout_changed_notify (GdlDockObject $object)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_nick_from_type (GType $type)
  returns Str
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_present (
  GdlDockObject $object,
  GdlDockObject $child
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_reduce (GdlDockObject $object)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_reorder (
  GdlDockObject    $object,
  GdlDockObject    $child,
  GdlDockPlacement $new_position,
  GValue           $other_data
)
  returns uint32
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_set_long_name (
  GdlDockObject $object,
  Str           $name
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_set_manual (GdlDockObject $object)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_set_name (
  GdlDockObject $object,
  Str           $name
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_set_pixbuf (
  GdlDockObject $object,
  GdkPixbuf     $icon
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_set_stock_id (
  GdlDockObject $object,
  Str           $stock_id
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_set_type_for_nick (
  Str   $nick,
  GType $type
)
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_thaw (GdlDockObject $object)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_type_from_nick (Str $nick)
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_object_unbind (GdlDockObject $object)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_param_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }
