-- START:note
local function note(letter, octave)
   local notes = {
      C  = 0,      Cs = 1,      D  = 2,      Ds = 3,      E  = 4,
      F  = 5,      Fs = 6,      G  = 7,      Gs = 8,      A  = 9,
      As = 10,     B  = 11
   }

   local notes_per_octave = 12

   return (octave + 1) * notes_per_octave + notes[letter]
end
-- END:note

-- START:duration
local tempo = 100

local function duration(value)
   local quarter   = 60 / tempo
   local durations = {
      h  = 2.0,
      q  = 1.0,
      ed = 0.75,
      e  = 0.5,
      s  = 0.25,
   }

   return durations[value] * quarter
end
-- END:duration

-- START:velocity
local volumes = {
   ['--'] = 0x20,  -- pp
   ['-']  = 0x40,  -- p
   ['']   = 0x60,  -- mf (default)
   ['+']  = 0x7f,  -- f
   ['++'] = 0x7f,  -- ff
}

local function velocity(mark)
   return volumes[mark]
end
-- END:velocity

-- START:parse_note
local function parse_note(s)
   local letter, octave, value, mark =
      string.match(s, "([A-Gs]+)(%d+)(%a+)([%+%-]*)")

   if not (letter and octave and value) then
      return nil
   end

   return {
      note     = note(letter, octave),
      duration = duration(value),
      velocity = velocity(mark)
   }
end
-- END:parse_note

-- START:play
local scheduler = require 'scheduler'

local NOTE_DOWN = 0x90
local NOTE_UP   = 0x80

local port = 0

local function play(note, duration, vel)
   vel = vel or velocity('')
   midi_send(port, NOTE_DOWN, note, vel)
   scheduler.wait(duration)
   midi_send(port, NOTE_UP, note, vel)
end
-- END:play

-- START:meta
local mt = {
   __index = function(t, s)
      local result = parse_note(s)
      return result or rawget(t, s)
   end
}

setmetatable(_G, mt)
-- END:meta

-- START:part
local function part(t)
   local function play_part()
      for i = 1, #t do
         play(t[i].note, t[i].duration, t[i].velocity)
      end
   end

   scheduler.schedule(0.0, coroutine.create(play_part))
end
-- END:part

-- START:go
local function set_tempo(bpm)
   tempo = bpm
end

local function set_port(p)
   port = p
end

local function go()
   scheduler.run()
end
-- END:go

-- START:module
return {
   parse_note = parse_note,
   play = play,
   part = part,
   set_tempo = set_tempo,
   set_port = set_port,
   go = go
}
-- END:module
