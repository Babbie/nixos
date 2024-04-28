import Gtk from "types/@girs/gtk-3.0/gtk-3.0";
import Window from "types/widgets/window";

const hyprland = await Service.import("hyprland");

const date = Variable('', {
  poll: [1000, 'date'],
});

const pactl = Variable({ count: 0, msg: '' }, {
  listen: ['pactl subscribe', (msg) => ({
    count: pactl.value.count + 1,
    msg: msg,
  })],
});

pactl.connect('changed', ({ value }) => {
  print(value.msg, value.count);
});

const label = Widget.Label({ 
  label: pactl.bind().as(({ count, msg }) => {
    return `${msg} ${count}`;
  }),
});

label.connect('notify::label', ({ label }) => {
  print('label changed to ', label);
});

const Bar = (monitor = 0) => Widget.Window({
  monitor,
  name: `bar${monitor}`,
  exclusivity: "exclusive",
  anchor: ['top', 'left', 'right'],
  child: Widget.Label({label: "I Exist on: " + monitor}) 
});

const bars: { [name: string] : Gtk.Window } = {};

hyprland.connect("monitor-added", (h, name) => {
  const monitor = h.monitors.find(m => m.name === name);
  print("MONITOR: ", name);
  if (monitor !== undefined) {
    bars[monitor.name] = Bar(monitor.id);
    App.addWindow(bars[monitor.name]);
  }
  print("BARS: ", bars);
});

hyprland.connect("monitor-removed", (_, name) => {
  print("RMONITOR: ", name);
  const bar = bars[name];
  print("RBAR: ", name);
  if (bar !== undefined) {
    delete bars[name];
  }
});

const windows: Gtk.Window[] = [];

for (const monitor of hyprland.monitors)
{
  bars[monitor.name] = Bar(monitor.id);
  windows.push(bars[monitor.name]);
}

App.config({
  windows,
  style: App.configDir + "/css/style.css",
})
