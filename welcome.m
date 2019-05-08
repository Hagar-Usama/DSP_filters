% Copyright (C) 2018 Hagar Usama
% 
% This program is free software; you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% -*- texinfo -*- 
% @deftypefn {Function File} {@var{retval} =} welcome (@var{input1}, @var{input2})
%
% @seealso{}
% @end deftypefn

% Author: Hagar Usama
% Created: 2018-11-25

function [retval] = welcome ()
retval = 1;
    fprintf('********************************************************\n');
    fprintf('****************** Welcome to My project :) ************\n');
    fprintf('********************************************************\n\n')
    fprintf('********************************************************\n');
      
    fprintf('For Impulse    >> 1\t DC Signal   >> 2\n');
    fprintf('    Ramp       >> 3\t Exponential >> 4\n');
    fprintf('    Sinusoidal >> 5\n');
    
    fprintf('********************************************************\n');
    fprintf('********************************************************\n');


end
