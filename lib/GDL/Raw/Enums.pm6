use v6.c;

use NativeCall;

use GLib::Raw::Definitions;

unit package GDL::Raw::Enums;

constant GdlDockBarStyle is export := guint32;
our enum GdlDockBarStyleEnum is export <
  GDL_DOCK_BAR_ICONS
  GDL_DOCK_BAR_TEXT
  GDL_DOCK_BAR_BOTH
  GDL_DOCK_BAR_AUTO
>;

constant GdlDockItemBehavior is export := guint32;
our enum GdlDockItemBehaviorEnum is export <
  GDL_DOCK_ITEM_BEH_NORMAL
  GDL_DOCK_ITEM_BEH_NEVER_FLOATING
  GDL_DOCK_ITEM_BEH_NEVER_VERTICAL
  GDL_DOCK_ITEM_BEH_NEVER_HORIZONTAL
  GDL_DOCK_ITEM_BEH_LOCKED
  GDL_DOCK_ITEM_BEH_CANT_DOCK_TOP
  GDL_DOCK_ITEM_BEH_CANT_DOCK_BOTTOM
  GDL_DOCK_ITEM_BEH_CANT_DOCK_LEFT
  GDL_DOCK_ITEM_BEH_CANT_DOCK_RIGHT
  GDL_DOCK_ITEM_BEH_CANT_DOCK_CENTER
  GDL_DOCK_ITEM_BEH_CANT_CLOSE
  GDL_DOCK_ITEM_BEH_CANT_ICONIFY
  GDL_DOCK_ITEM_BEH_NO_GRIP
>;

constant GdlDockItemButtonImageType is export := guint32;
our enum GdlDockItemButtonImageTypeEnum is export <
  GDL_DOCK_ITEM_BUTTON_IMAGE_CLOSE
  GDL_DOCK_ITEM_BUTTON_IMAGE_ICONIFY
>;

constant GdlDockObjectFlags is export := guint32;
our enum GdlDockObjectFlagsEnum is export <
  GDL_DOCK_AUTOMATIC
  GDL_DOCK_ATTACHED
  GDL_DOCK_IN_REFLOW
  GDL_DOCK_IN_DETACH
>;

constant GdlDockPlacement is export := guint32;
our enum GdlDockPlacementEnum is export <
  GDL_DOCK_NONE
  GDL_DOCK_TOP
  GDL_DOCK_BOTTOM
  GDL_DOCK_RIGHT
  GDL_DOCK_LEFT
  GDL_DOCK_CENTER
  GDL_DOCK_FLOATING
>;

constant GdlSwitcherStyle is export := guint32;
our enum GdlSwitcherStyleEnum is export <
  GDL_SWITCHER_STYLE_TEXT
  GDL_SWITCHER_STYLE_ICON
  GDL_SWITCHER_STYLE_BOTH
  GDL_SWITCHER_STYLE_TOOLBAR
  GDL_SWITCHER_STYLE_TABS
  GDL_SWITCHER_STYLE_NONE
>;
