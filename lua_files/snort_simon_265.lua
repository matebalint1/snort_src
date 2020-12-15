---------------------------------------------------------------------------
-- Snort++ configuration
---------------------------------------------------------------------------

-- there are over 200 modules available to tune your policy.
-- many can be used with defaults w/o any explicit configuration.
-- use this conf as a template for your specific configuration.

-- 1. configure defaults
-- 2. configure inspection
-- 3. configure bindings
-- 4. configure performance
-- 5. configure detection
-- 6. configure filters
-- 7. configure outputs
-- 8. configure tweaks

---------------------------------------------------------------------------
-- 1. configure defaults
---------------------------------------------------------------------------

-- HOME_NET and EXTERNAL_NET must be set now
-- setup the network addresses you are protecting
HOME_NET = 'any'

-- set up the external network addresses.
-- (leave as "any" in most situations)
EXTERNAL_NET = 'any'

--include 'snort_defaults.lua'
--include 'file_magic.lua'

---------------------------------------------------------------------------
-- 2. configure inspection
---------------------------------------------------------------------------

-- mod = { } uses internal defaults
-- you can see them with snort --help-module mod

-- mod = default_mod uses external defaults
-- you can see them in snort_defaults.lua

-- the following are quite capable with defaults:

--stream = { }
--stream_ip = { }
--stream_icmp = { }
--stream_tcp = { }
--stream_udp = { }
--stream_user = { }
--stream_file = { }

--arp_spoof = { }
--back_orifice = { }
--dnp3 = { }
--dns = { }
--http_inspect = { }
--http2_inspect = { }
--imap = { }
--modbus = { }
--normalizer = { }
--pop = { }
--rpc_decode = { }
--sip = { }
--ssh = { }
--ssl = { }
--telnet = { }

--dce_smb = { }
--dce_tcp = { }
--dce_udp = { }
--dce_http_proxy = { }
--dce_http_server = { }

-- see snort_defaults.lua for default_*
--gtp_inspect = default_gtp
--port_scan = default_med_port_scan
--smtp = default_smtp

--ftp_server = default_ftp_server
--ftp_client = { }
--ftp_data = { }

-- see file_magic.lua for file id rules
--file_id = { file_rules = file_magic }
-- goal={vars = "simpleIOGenericIOLLN0GOgcbAnalogValues_0_0|simpleIOGenericIOLLN0GOgcbAnalogValues_0_1"; formula="simpleIOGenericIOLLN0GOgcbAnalogValues_0min=simpleIOGenericIOLLN0GOgcbAnalogValues_0_1 * 0.9;";}

goose = {vars="simpleIOGenericIOLLN0GOgcbAnalogValues_0_0;simpleIOGenericIOLLN0GOgcbAnalogValues_0_1;simpleIOGenericIOLLN0GOgcbAnalogValues_0_2;simpleIOGenericIOLLN0GOgcbAnalogValues_0_3;simpleIOGenericIOLLN0GOgcbAnalogValues_0_4;simpleIOGenericIOLLN0GOgcbAnalogValues_0_5;simpleIOGenericIOLLN0GOgcbAnalogValues_0_6;simpleIOGenericIOLLN0GOgcbAnalogValues_0_7;simpleIOGenericIOLLN0GOgcbAnalogValues_0_8;simpleIOGenericIOLLN0GOgcbAnalogValues_0_9;simpleIOGenericIOLLN0GOgcbAnalogValues_0_10;"; formula="alert1: simpleIOGenericIOLLN0GOgcbAnalogValues_0_0 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_1 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_2 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_3 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_4 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_5 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_6 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_7 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_8 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_9 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_10 > 5";}

-- goals = {vars="svpub1_1_1"; formula="svpub1_1min=svpub1_1_1"}

sv = {vars="svpub1_1_1"; formula="alert1: svpub1_1_1 > 231;alert2: svpub1_1_1 > 231.5"}--vars="simpleIOGenericIOLLN0GOgcbAnalogValues_0_0;"; formula="alert1: simpleIOGenericIOLLN0GOgcbAnalogValues_0_0 < 5";}--{vars="simpleIOGenericIOLLN0GOgcbAnalogValues_0_;simpleIOGenericIOLLN0GOgcbAnalogValues_0_2;svID_0_2;"; formula="ALERT_3: simpleIOGenericIOLLN0GOgcbAnalogValues_0_1 < (simpleIOGenericIOLLN0GOgcbAnalogValues_0_2 + simpleIOGenericIOLLN0GOgcbAnalogValues_0_1) / 2 * 0.9 | simpleIOGenericIOLLN0GOgcbAnalogValues_0_1 > simpleIOGenericIOLLN0GOgcbAnalogValues_0_1 * 1.1;ALERT_4: svID_0_2 > 5;";}

-- the following require additional configuration to be fully effective:

--appid =
--{
    -- appid requires this to use appids in rules
    --app_detector_dir = 'directory to load appid detectors from'
--}

--[[
reputation =
{
    -- configure one or both of these, then uncomment reputation
    --blacklist = 'blacklist file name with ip lists'
    --whitelist = 'whitelist file name with ip lists'
}
--]]

---------------------------------------------------------------------------
-- 3. configure bindings
---------------------------------------------------------------------------

--wizard = default_wizard
--[[
binder =
{
    -- port bindings required for protocols without wizard support
    { when = { proto = 'udp', ports = '53', role='server' },  use = { type = 'dns' } },
    { when = { proto = 'tcp', ports = '53', role='server' },  use = { type = 'dns' } },
    { when = { proto = 'tcp', ports = '111', role='server' }, use = { type = 'rpc_decode' } },
    { when = { proto = 'tcp', ports = '502', role='server' }, use = { type = 'modbus' } },
    { when = { proto = 'tcp', ports = '2123 2152 3386', role='server' }, use = { type = 'gtp' } },

    { when = { proto = 'tcp', service = 'dcerpc' }, use = { type = 'dce_tcp' } },
    { when = { proto = 'udp', service = 'dcerpc' }, use = { type = 'dce_udp' } },

    { when = { service = 'netbios-ssn' },      use = { type = 'dce_smb' } },
    { when = { service = 'dce_http_server' },  use = { type = 'dce_http_server' } },
    { when = { service = 'dce_http_proxy' },   use = { type = 'dce_http_proxy' } },

    { when = { service = 'dnp3' },             use = { type = 'dnp3' } },
    { when = { service = 'dns' },              use = { type = 'dns' } },
    { when = { service = 'ftp' },              use = { type = 'ftp_server' } },
    { when = { service = 'ftp-data' },         use = { type = 'ftp_data' } },
    { when = { service = 'gtp' },              use = { type = 'gtp_inspect' } },
    { when = { service = 'imap' },             use = { type = 'imap' } },
    { when = { service = 'http' },             use = { type = 'http_inspect' } },
    { when = { service = 'http2' },            use = { type = 'http2_inspect' } },
    { when = { service = 'modbus' },           use = { type = 'modbus' } },
    { when = { service = 'pop3' },             use = { type = 'pop' } },
    { when = { service = 'ssh' },              use = { type = 'ssh' } },
    { when = { service = 'sip' },              use = { type = 'sip' } },
    { when = { service = 'smtp' },             use = { type = 'smtp' } },
    { when = { service = 'ssl' },              use = { type = 'ssl' } },
    { when = { service = 'sunrpc' },           use = { type = 'rpc_decode' } },
    { when = { service = 'telnet' },           use = { type = 'telnet' } },

    { use = { type = 'wizard' } }
}
]]
---------------------------------------------------------------------------
-- 4. configure performance
---------------------------------------------------------------------------

-- use latency to monitor / enforce packet and rule thresholds
latency = { }

-- use these to capture perf data for analysis and tuning
--profiler = { }
perf_monitor = { 
    modules = {
        {name = 'latency',
        pegs = [[ ]] }
    }
}
daq = { batch_size = 1}

---------------------------------------------------------------------------
-- 5. configure detection
---------------------------------------------------------------------------

--[[references = default_references
classifications = default_classifications

ips =
{
    -- use this to enable decoder and inspector alerts
    --enable_builtin_rules = true,

    -- use include for rules files; be sure to set your path
    -- note that rules files can include other rules files
    --include = 'snort3-community.rules'
}
]]--
-- use these to configure additional rule actions
-- react = { }
-- reject = { }
-- rewrite = { }

---------------------------------------------------------------------------
-- 6. configure filters
---------------------------------------------------------------------------

-- below are examples of filters
-- each table is a list of records

--[[
suppress =
{
    -- don't want to any of see these
    { gid = 1, sid = 1 },

    -- don't want to see these for a given server
    { gid = 1, sid = 2, track = 'by_dst', ip = '1.2.3.4' },
}
--]]

--[[
event_filter =
{
    -- reduce the number of events logged for some rules
    { gid = 1, sid = 1, type = 'limit', track = 'by_src', count = 2, seconds = 10 },
    { gid = 1, sid = 2, type = 'both',  track = 'by_dst', count = 5, seconds = 60 },
}
--]]

--[[
rate_filter =
{
    -- alert on connection attempts from clients in SOME_NET
    { gid = 135, sid = 1, track = 'by_src', count = 5, seconds = 1,
      new_action = 'alert', timeout = 4, apply_to = '[$SOME_NET]' },

    -- alert on connections to servers over threshold
    { gid = 135, sid = 2, track = 'by_dst', count = 29, seconds = 3,
      new_action = 'alert', timeout = 1 },
}
--]]

---------------------------------------------------------------------------
-- 7. configure outputs
---------------------------------------------------------------------------

-- event logging
-- you can enable with defaults from the command line with -A <alert_type>
-- uncomment below to set non-default configs
--alert_csv = { }
--alert_fast = { }
alert_full = { file = true}
--alert_sfsocket = { }
--alert_syslog = { level = info }
--unified2 = { }

-- packet logging
-- you can enable with defaults from the command line with -L <log_type>
--log_codecs = { }
--log_hext = { }
--log_pcap = { }

-- additional logs
--packet_capture = { }
--file_log = { }
detection = {trace = 0x20 + 0x10 + 0x2 + 0x4}
---------------------------------------------------------------------------
-- 8. configure tweaks
---------------------------------------------------------------------------

if ( tweaks ~= nil ) then
    include(tweaks .. '.lua')
end
