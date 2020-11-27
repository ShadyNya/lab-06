lgi = require 'lgi'
sqlite = require 'lsqlite3'

gtk = lgi.Gtk
pixbuf = lgi.GdkPixbuf.Pixbuf

gtk.init()

bld = gtk.Builder()
bld:add_from_file('Studentova473lab-06.glade')

ui = bld.objects

rdr_txt = gtk.CellRendererText {}
rdr_pix = gtk.CellRendererPixbuf {}

c1 = gtk.TreeViewColumn { title = 'name', {rdr_txt, {text = 1}} }
c2 = gtk.TreeViewColumn { title = 'value', {rdr_txt, {text = 2}} }
c3 = gtk.TreeViewColumn { title = 'image', {rdr_pix, {pixbuf = 3}} }

ui.lst_items:append_column(c1)
ui.lst_items:append_column(c2)
ui.lst_items:append_column(c3)

db = sqlite.open('Studentova473lab-06.lua')
db = sqlite.open('lab-06.db')

for row in db:nrows('SELECT * FROM list1') do
	px = pixbuf.new_from_file(row.image)

	el = ui.stor_items:append()
	ui.stor_items[el] = { [1] = row.name, [2] = row.value, [3] = px }
end

db:close()

ui.wnd:show_all()
gtk.main()

