use v6.c;

use NativeCVall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;
use GDL::Raw::Structs;

unit package GDL::Raw::Class;

class GdlDockBarClass is repr<CStruct> is export {
	HAS GtkBoxClass $!parent_class;
}

class GdlDockItemButtonImageClass is repr<CStruct> is export {
	HAS GtkWidgetClass $!parent_class;
}

class GdlDockItemGripClass is repr<CStruct> is export {
	HAS GtkContainerClass $!parent_class;
}


class GdlDockLayoutClass is repr<CStruct> is export {
	HAS GObjectClass $!g_object_class;
}

class GdlDockNotebookClass is repr<CStruct> is export {
	HAS GdlDockItemClass $!parent_class;
	has gpointer         $!priv        ;
}

class GdlDockPanedClass is repr<CStruct> is export {
	HAS GdlDockItemClass $!parent_class;
}

class GdlDockPlaceholderClass is repr<CStruct> is export {
	HAS GdlDockObjectClass $!parent_class;
}

class GdlPreviewWindowClass is repr<CStruct> is export {
	HAS GtkWindowClass $!parent_class;
}

class GdlSwitcherClass is repr<CStruct> is export {
	HAS GtkNotebookClass $!parent_class;
	has gpointer         $!priv        ;
}
