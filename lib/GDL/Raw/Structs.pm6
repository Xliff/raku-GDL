use v6.c;

use NativeCall;

use Cairo;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions;
use GDL::Raw::Definitions;
use GDL::Raw::Enums;

unit package GDL::Raw::Structs;

class GdlDockObject is repr<CStruct> is export {
	HAS GtkContainer       $!container        ;
	has GdlDockObjectFlags $!deprecated_flags ;
	has GObject            $!deprecated_master;
	has gpointer           $!priv             ;
}

class GdlDock is repr<CStruct> is export {
	HAS GdlDockObject $!object;
	has gpointer      $!priv  ;
}

class GdlDockBar is repr<CStruct> is export {
	HAS GtkBox   $!parent         ;
	has GdlDock  $!deprecated_dock;
	has gpointer $!priv           ;
}

class GdlDockItem is repr<CStruct> is export {
	HAS GdlDockObject $!object;
	has gpointer      $!priv  ;
}

class GdlDockItemButtonImage is repr<CStruct> is export {
	HAS GtkWidget                  $!parent    ;
	has GdlDockItemButtonImageType $!image_type;
}

class GdlDockItemGrip is repr<CStruct> is export {
	HAS GtkContainer $!parent;
	has gpointer     $!priv  ;
}

class GdlDockMaster is repr<CStruct> is export {
	HAS GObject  $!object;
	has gpointer $!priv  ;
}

class GdlDockLayout is repr<CStruct> is export {
	HAS GObject       $!g_object         ;
	has gboolean      $!deprecated_dirty ;
	has GdlDockMaster $!deprecated_master;
	has gpointer      $!priv             ;
}

class GdlDockNotebook is repr<CStruct> is export {
	HAS GdlDockItem $!item;
	has gpointer    $!priv;
}

class GdlDockPaned is repr<CStruct> is export {
	HAS GdlDockItem $!dock_item;
	has gpointer    $!priv     ;
}

class GdlDockPlaceholder is repr<CStruct> is export {
	HAS GdlDockObject $!object;
	has gpointer      $!priv  ;
}

class GdlDockRequest is repr<CStruct> is export {
	has GdlDockObject                $!applicant;
	has GdlDockObject                $!target   ;
	has GdlDockPlacement             $!position ;
	has Cairo::cairo_rectangle_int_t $!rect     ;
	has GValue                       $!extra    ;

	method applicant is rw {
		Proxy.new:
			FETCH => -> $                     { $!applicant },
			STORE => -> $, GdlDockObject() \v { $!applicant := v }
	}

	method target is rw {
		Proxy.new:
			FETCH => -> $                     { $!target },
			STORE => -> $, GdlDockObject() \v { $!target := v }
	}

	method position is rw {
		Proxy.new:
			FETCH => -> $           { $!position },

			STORE => -> $, Int() $vv {
				my GdlDockPlacement $v = $vv;
				$!position = $v
			}
	}

	method rect is rw {
		Proxy.new:
			FETCH => -> $     { $!rect },
			STORE => -> $, \v { $!rect := v }
	}

	method extra is rw {
		Proxy.new:
			FETCH => -> $              { $!extra },
			STORE => -> $, GValue() \v { $!extra := v }
	}

}

class GdlDockTablabel is repr<CStruct> is export {
	HAS GtkBin         $!parent          ;
	has guint          $.drag_handle_size is rw;
	has GtkWidget      $!item            ;
	has GdkWindow      $!event_window    ;
	has gboolean       $!active          ;
	has GdkEventButton $!drag_start_event;
	has gboolean       $!pre_drag        ;
}

class GdlPreviewWindow is repr<CStruct> is export {
	HAS GtkWindow $!parent_instance;
}

class GdlSwitcher is repr<CStruct> is export {
	HAS GtkNotebook $!parent;
	has gpointer    $!priv  ;
}
