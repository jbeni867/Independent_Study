extern "C"
{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
}

#include <cstdio>
#include <map>
#include <memory>

#include <rtmidi/RtMidi.h>

static std::map<unsigned int, std::unique_ptr<RtMidiOut>> midi_outs;

static RtMidiOut& midi_out(unsigned int port)
{
    auto it = midi_outs.find(port);
    if (it == midi_outs.end())
    {
        auto out = std::make_unique<RtMidiOut>();
        out->openPort(port);
        it = midi_outs.emplace(port, std::move(out)).first;
    }
    return *it->second;
}

int midi_send(lua_State* L)
{
    double port   = lua_tonumber(L, -4);
    double status = lua_tonumber(L, -3);
    double data1  = lua_tonumber(L, -2);
    double data2  = lua_tonumber(L, -1);

    std::vector<unsigned char> message(3);
    message[0] = static_cast<unsigned char>(status);
    message[1] = static_cast<unsigned char>(data1);
    message[2] = static_cast<unsigned char>(data2);

    midi_out(static_cast<unsigned int>(port)).sendMessage(&message);

    return 0;
}

static void report(lua_State* L, int status)
{
    if (status != LUA_OK)
    {
        fprintf(stderr, "%s\n", lua_tostring(L, -1));
        lua_pop(L, 1);
    }
}

int main(int argc, const char* argv[])
{
    if (argc < 1) { return -1; }

    RtMidiOut probe;
    if (probe.getPortCount() < 1) { return -1; }

    lua_State* L = luaL_newstate();
    luaL_openlibs(L);

    lua_pushcfunction(L, midi_send);
    lua_setglobal(L, "midi_send");

    report(L, luaL_dostring(L, "song = require 'notation'"));

    report(L, luaL_dofile(L, argv[1]));

    report(L, luaL_dostring(L, "song.go()"));

    lua_close(L);
    return 0;
}
