function [code] = comment(txt)
import GGen.*
code = ['~ ;' txt];
al(code);

end