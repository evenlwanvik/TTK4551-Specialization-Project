figure(18);     
tED = Tmean4.tED-delay4;
t = Ts4.t; p = Ts4.ART; v = Ts4.velocity;
tIdx = find( t>tED(50) & t<tED(50+1));

p = p(tIdx); v = v(tIdx); t = t(tIdx);
v_line = linspace(v(1), v(end), N); v_new = v - v_line'+mean(v_line);  
p_line = linspace(p(1), p(end), N); p_new = p - p_line'+mean(p_line);


N = length(t); fs = 1/(t(2)-t(1)); f = (0:1/(N-1):1)*fs;
P = fft(p_new); V = fft(v_new); Z = P./V/N;

subplot(2,1,1); plot(f, abs(Z), '-*'); xlim([0,100]);set(gca, 'box','off'); 
xlabel('Frequency [Hz]'); 
subplot(2,1,2); plot(f, angle(Z)*180/pi, '-*'); 
set(gca, 'box','off', 'XAxisLocation','origin','XTickLabel','', ...
    'YTick',[-30, 0, 30, 60],'YTickLabel',{['-30' char(176)], ['0' char(176)], ['30' char(176)], ['60' char(176)]})
axis([0, 8, -30, 60])

%% 

figure()
yyaxis left
plot(T4, R4); ylabel('R_{SVR}')
yyaxis right
plot(T4, C4); ylabel('C_{arterial}')
xlabel('Time [sec]')

%%

R_dft4_ok = abs(fft(R4)/length(R4));
C_dft4_ok = abs(fft(C4)/length(C4));
FS4 = 1/(T4(2)-T4(1)); 
F4 = (0:1/(length(R4)-1):1)*FS4;

figure(50)
subplot(2,1,1)
yyaxis left
plot(F4, R_dft4_ok); ylabel('|R_{SVR}(\omega)|')
ylim([0,60])
yyaxis right
plot(F4, C_dft4_ok); ylabel('|C_{arterial}(\omega)|')
xlabel('Frequency [Hz]')
xlim([0,0.1])
ylim([0,15e-6])

%%

%R_dft4_ok = abs(fft(R4_intp)/N4);
%C_dft4_ok = abs(fft(C4_intp)/N4);
%subplot(2,1,2)
yyaxis left
plot(f4, abs(R_dft4)); ylabel('|R_{SVR}(\omega)|')
ylim([0,0.05])
yyaxis right
plot(f4, abs(C_dft4)); ylabel('|C_{arterial}(\omega)|')
xlabel('Frequency [Hz]')
xlim([0,1])
ylim([0,0.05])

%%

plot(f4, abs(R_dft4), f4, abs(C_dft4)); 
ylabel('(1)')
xlabel('Frequency [Hz]')
xlim([0,0.4])
ylim([0,0.05])
legend('SVR', 'C')
