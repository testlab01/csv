-module(write_file).

-export([csv/3]).

csv(Path, Modes, Data) ->
	File = string:concat(Path, FileName ++ ".csv"),
	case file:open(File, Modes) of
		{ok, IoDevice} ->
			ok = wcsv(File, Data, Modes),
			file:close(IoDevice);
		{error, Reason} ->
			{error, Reason}
	end.

wcsv(File, [H | T], Modes) ->
	file:write_file(File, io_lib:fwrite("~p", [H]), Modes),
	wcsv1(File, T, Modes);
wcsv(File, [], Modes) ->
	ok.
%% @hidden
wcsv1(File, [H | T], Modes) ->
	file:write_file(File, io_lib:fwrite(",~p", [H]), Modes),
	wcsv1(File, T, Modes);
wcsv1(File, [], Modes) ->
	file:write_file(File, "\n", Modes).
