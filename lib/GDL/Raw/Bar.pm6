use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GTK::Raw::Enums;
use GTK::Raw::Definitions;
use GDL::Raw::Definitions;
use GDL::Raw::Enums;
use GDL::Raw::Structs;

unit package GDL::Raw::Bar;

### /usr/src/gdl/gdl/gdl-dock-bar.h

sub gdl_dock_bar_get_orientation (GdlDockBar $dockbar)
  returns GtkOrientation
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_bar_get_style (GdlDockBar $dockbar)
  returns GdlDockBarStyle
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_bar_get_type
  returns GType
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_bar_new (GObject $master)
  returns GtkWidget
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_bar_set_orientation (
  GdlDockBar     $dockbar,
  GtkOrientation $orientation
)
  is      native(gdl)
  is      export
{ * }

sub gdl_dock_bar_set_style (
  GdlDockBar      $dockbar,
  GdlDockBarStyle $style
)
  is      native(gdl)
  is      export
{ * }
