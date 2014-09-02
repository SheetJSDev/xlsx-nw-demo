var J = require('j');
var fs = require('fs');
var gui = require('nw.gui');

add_menu(gui);

var ldPath = gui.App.argv[0];
if(!fs.existsSync(ldPath)) doit();
else process_path(ldPath);

document.querySelector('#chooser').addEventListener('click', doit);

function doit() { chooseFile('#fileDialog', function(evt) { process_path(this.value); }); }

function process_path(ldPath, mode) {
	w = J.readFile(ldPath);
	var payload, o, htmlo = false;
	switch(mode || 'html') {
		case 'csv': payload = J.utils.to_csv(w); break;
		case 'html': payload = J.utils.to_html(w); break;
	}
	filename.innerText = ldPath;
	ver.innerText = J.version;
	sheets.innerText = w[1].SheetNames.map(function(x){return "-"+x;}).join("\n");

	switch(mode||'html') {
		case 'csv': o = w[1].SheetNames.map(function(s) { return "Sheet: " + s + "\n\n" + payload[s]; }).join("\n"); break;
		case 'html': o = w[1].SheetNames.map(function(s) { return payload[s]; }).join("\n"); htmlo = true; break;
	}
	outpre.style.visibility = "hidden";
	outdiv.style.visibility = "hidden";
	if(htmlo) { outdiv.innerHTML = o; outdiv.style.visibility = "visible"; }
	else { outpre.innerText = o; outpre.style.visibility = "visible"; }
}

function add_menu(gui) {
	var menu = new gui.Menu({type: 'menubar'});
	try { menu.createMacBuiltin("xlpreview"); } catch(e) { }
	gui.Window.get().menu = menu;
}

function chooseFile(name, cb) {
	var chooser = document.querySelector(name);
	chooser.addEventListener("change", cb, false);
	chooser.click();
}
