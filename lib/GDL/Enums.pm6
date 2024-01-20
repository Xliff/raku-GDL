use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Subs;
use GDL::Raw::Definitions;

class GDL::Enums::Behavior {

  method get_type {
    state ($n, $t);

    sub gdl_dock_item_behavior_get_type
      returns GType
      is      native(gdl)
    { * }

    unstable_get_type( self.^name, &gdl_dock_item_behavior_get_type, $n, $t );
  }

}

class GDL::Enums::DockBarStyle {

  method get_type {
    state ($n, $t);

    sub gdl_dock_bar_style_get_type
      returns GType
      is      native(gdl)
    { * }

    unstable_get_type( self.^name, &gdl_dock_bar_style_get_type, $n, $t );
  }

}

class GDL::Enums::SwitcherStyle {

  method get_type {
    state ($n, $t);

    sub gdl_switcher_style_get_type
      returns GType
      is      native(gdl)
    { * }

    unstable_get_type( self.^name, &gdl_switcher_style_get_type, $n, $t );
  }

}
