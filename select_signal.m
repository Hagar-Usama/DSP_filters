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
% @deftypefn {Function File} {@var{retval} =} select_signal (@var{input1}, @var{input2})
%
% @seealso{}
% @end deftypefn

% Author: Hagar Usama
% Created: 2018-11-24

function [new_x ,new_y ] = select_signal (input1 ,start_point, breakpoint ,sample_freq)
  new_y = [start_point:1/sample_freq:breakpoint]*0 ;
  new_x = start_point:1/sample_freq:breakpoint;
  switch (input1)
  %%%% impulse %%%%%
  case 1 
   prompt = 'Enter Amplitude >> ';
   amp = input(prompt);
   
   %line([start_point , start_point] , [0 , amp]);
   new_y(1) = amp;
       
  %%%% DC Signal %%%%%%
  case 2
    prompt = 'Enter Amplitude >> ';
    amp = input(prompt);
    
    x=[start_point , breakpoint];
    y= [ amp , amp ];
    %line(x,y);
   
   for i = 1: length(new_y)
       new_y(i) = amp;
   end
       
  %%%% Ramp %%%%  
  case 3
    prompt = 'Enter Slope >> ';
    slope = input(prompt);
    prompt = 'Enter Intercept >> ';
    intercept = input(prompt);
    %y1 = slope*start_point + intercept;
    %y2 = slope*breakpoint + intercept;
    %plot([start_point , breakpoint] , [y1 , y2]);
    
    t = start_point:1/sample_freq:breakpoint;
    new_y = slope*t + intercept;
    
   %%%% exponential %%%%
   case 4
   prompt = 'Enter Amplitude >> ';
   amp = input(prompt);
   prompt = 'Enter Exponent >> ';
   exponent = input(prompt);
   prompt = 'Enter Shift >> ';
   shift= input(prompt);
   x = start_point:1/sample_freq:breakpoint;
   new_y = amp*exp(exponent*x + shift); %% amp here is just a dc shift
   %plot(x,y);
  
   
   %%%%% sinusoidal %%%%%
   case 5
   prompt = 'Enter Amplitude >> ';
   amp = input(prompt);
   prompt = 'Enter Frequency >> ';
   freq = input(prompt);
   prompt = 'Enter phase >> ';
   phase = input(prompt);
   prompt = 'Enter DC shift >> ';
   dc_shift = input(prompt);
   x = start_point:1/sample_freq:breakpoint;
   new_y = amp*sin(2*pi*x*freq + phase) + dc_shift;
   %plot(x,y);
   
   otherwise
    printf('Choice not valid');
    
    
  end
