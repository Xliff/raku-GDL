use v6.c;

use GDL::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Dialog;
use GTK::Label;
use GTK::RadioButton;
use GTK::ScrolledWindow;
use GTK::TextView;
use GDL::Master;
use GDL::Bar;
use GDL::Dock;
use GDL::Item;
use GDL::Layout;

sub on-style-button-toggled ($b, $d) {
  $d.master.switcher-style = $b<style> if $b.active;
}

sub create-style-button ($d, $b, $g, $s, $t) {
  my $style  = $d.master.switcher-style;
  my $b1     = GTK::RadioButton.new-with-label-from-widget($g, $t);
  $b1.show;
  $b1<style> = $style;
  $b1.active = True if $style == $s;
  $b1.toggled.tap: SUB { on-style-button-toggled($b1, $d); }
  $b.pack-start($b1);
  $b1;
}

sub create-styles-item ($d) {
  ( my $v1 = GTK::Box.new-vbox ).show;

  my $g = GtkWidget;
  $g = create-style-button( $d, $v1, $g, |$_ )
    for [ GDL_SWITCHER_STYLE_ICON,    'Only icon' ],
        [ GDL_SWITCHER_STYLE_TEXT,    'Only text' ],
        [ GDL_SWITCHER_STYLE_BOTH,    'Both icons and texts'  ],
        [ GDL_SWITCHER_STYLE_TOOLBAR, 'Desktop toolbar style' ],
        [ GDL_SWITCHER_STYLE_TABS,    'Notebook tabs' ],
        [ GDL_SWITCHER_STYLE_NONE,    'None of the above' ];
  $v1;
}

sub create-item ($t) {
  ( my $b1 = GTK::Button.new-with-label($t) ).show;
  $b1;
}

sub create-text-item {
  ( my $v1 = GTK::Box.new-vbox ).show;
  ( my $sw = GTK::ScrolledWindow.new ).show;
  ( my $t  = GTK::TextView.new ).show;
  $t.wrap-mode = GTK_WRAP_WORD;
  $v1.pack-start($sw, True, True);
  $sw.set-policy( :auto );
  $sw.shadow-type = GTK_SHADOW_ETCHED_IN;
  $sw.add($t);
  $v1;
}

sub button-dump-cb ($d) {
  $d.save-to-file('layout.xml');
  'layout.xml'.IO.slurp.say;
}

sub save-layout-cb ($d) {
  my $dialog = GTK::Dialog.new-with-buttons(
    'New Layout',
    OK => GTK_RESPONSE_OK
  );

  ( my $hbox = GTK::Box.new-hbox(8) ).border-width = 8;
  $dialog.action-area.pack-start($hbox);
  my ($label, $entry) = (GTK::Label.new('Name:'), GTK::Entry.new);
  $hbox.pack-start($label);
  $hbox.pack-start($entry, True, True);
  $hbox.show-all;
  $d.save-layout( $entry.text ) if $dialog.run == GTK_RESPONSE_OK;

  # cw: -XXX-
  #     This still needs work.... particularly for signals cleanup!
  #$dialog.destroy;
}

sub on-change-name ($w, $item) {
  state ($index, $toggle) = (10, True);

  $item.long-name = "Item { $index++ }";
  if $toggle {
    $item.hide;
    $w.label = 'hidden' if $w.^can('label');
  } else {
    $item.show;
    $w.label = 'shown' if $w.^can('label');
  }
  $toggle .= not;
}

sub MAIN {
  my $a = GTK::Application.new(
    name   => 'org.genex.gdl.test',
    width  => 400,
    height => 400
  );

  $a.activate.tap: SUB {
    $a.window.delete-event.tap: SUB { $a.quit( :gio ) }

    ( my $table = GTK::Box.new-vbox(5) ).border-width = 10;

    ( .tab-pos, .tab-reorderable ) = (GTK_POS_TOP, True )
      given ( my $master = ( my $dock = GDL::Dock.new ).master );

    my $layout  = GDL::Layout.new($dock);

    ( my $dockbar = GDL::Bar.new($dock) ).dockbar-style = GDL_DOCK_BAR_TEXT;

    my $box = GTK::Box.new-hbox(5);
    $box.pack-start($dockbar);
    $box.pack-end($dock, True, True);

    my (@i, @items, $i);
    @i.push:
      ($i = GDL::Item.new('item1', 'Item #1', GDL_DOCK_ITEM_BEH_LOCKED) );
    $i.add( create-text-item );
    $dock.add-item($i, GDL_DOCK_TOP);

    @i.push: (
      $i = GDL::Item.new-with-stock(
        'item2',
        'Item #2: Select the switcher style',
         'system-run',
         GDL_DOCK_ITEM_BEH_LOCKED
      )
    );
    $i.resize = False;
    $dock.add-item($i, GDL_DOCK_RIGHT);

    @i.push: (
      my $i3 = GDL::Item.new-with-stock(
        'item3',
        'Item #3: has accented characters (áéíóúñ)',
         'edit-redo', # convert
         :locked, :!close
      )
    );
    ( my $name-button = create-item('Change name:') ).clicked.tap: SUB {
      on-change-name($name-button, $i3);
    }
    $i3.add($name-button);
    $dock.add-item($i3, GDL_DOCK_BOTTOM);

    @items.push: (
      $i = GDL::Item.new-with-stock(
        'Item #4',
        'Item #4',
        'format-justify-fill',
        :locked, :!close
      );
    );
    $i.add( create-text-item );
    $dock.add-item($i, GDL_DOCK_BOTTOM);

    for 1..3 {
      my $n = "Item \#{ $_ + 4 }";
      @items.push: $i = GDL::Item.new-with-stock( $n, $n, 'document-new' );
      $i.add( create-text-item );
      @items.head.dock($i, GDL_DOCK_CENTER);
    }

    $i3.dock-to(@i.head, GDL_DOCK_TOP);
    @i[1].dock-to($i3, GDL_DOCK_RIGHT);
    @i[1].dock-to($i3, GDL_DOCK_LEFT);
    @i[1].float;

    .show for |@i, |@items;

    ( my $box2 = GTK::Box.new-hbox(5) ).homogeneous = True;

    ( my $button2 = GTK::Button.new-from-stock('document-save') ).clicked.tap(
      SUB { save-layout-cb($layout) }
    );

    ( my $button3 = GTK::Button.new-with-label('Dump XML') ).clicked.tap(
      SUB { button-dump-cb($layout) }
    );

    $a.window.show-all;
  }

  $a.run;
}
