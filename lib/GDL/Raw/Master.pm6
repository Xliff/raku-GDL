use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GDL::Raw::Definitions;
use GDL::Raw::Structs;

unit package GDL::Raw::Master;

### /usr/src/gdl/gdl/gdl-dock-master.h

sub gdl_dock_master_add (
  GdlDockMaster $master,
  GdlDockObject $object
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_master_foreach (
  GdlDockMaster $master,
                &function (GtkWidget, gpointer),
  gpointer      $user_data
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_master_foreach_toplevel (
  GdlDockMaster $master,
  gboolean      $include_controller,
                &function (GtkWidget, gpointer),
  gpointer      $user_data
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_master_get_controller (GdlDockMaster $master)
  returns GdlDockObject
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_master_get_dock_name (GdlDockMaster $master)
  returns Str
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_master_get_object (
  GdlDockMaster $master,
  Str           $nick_name
)
  returns GdlDockObject
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_master_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_master_remove (
  GdlDockMaster $master,
  GdlDockObject $object
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_master_set_controller (
  GdlDockMaster $master,
  GdlDockObject $new_controller
)
  is      native(gdl)
  is      export
{ * }
