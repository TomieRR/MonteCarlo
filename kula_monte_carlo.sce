// Parametry i wartość dokładna (analityczna)
k = 10;
V_dokladne = (2/k) * ((%pi)^(k/2)) / gamma(k/2); 
disp("V_dokladne = " + string(V_dokladne));

disp(" ");
disp("==============================================");
disp("ZADANIE 2: Monte Carlo - 1000 i 10000 prób");
disp("==============================================");

// Funkcja szacująca objętość kuli metodą Monte Carlo
function V=monte_carlo_kula(n, k)
    punkty = 2 * rand(n, k) - 1;          // Losowanie punktów z sześcianu [-1,1]^k
    odleglosc_kwadrat = sum(punkty .^ 2, 2); // Kwadrat odległości od środka (po wierszach)
    trafione = sum(odleglosc_kwadrat <= 1);  // Zliczanie punktów wewnątrz kuli
    V_szescian = 2^k;                     // Objętość sześcianu ograniczającego
    V = (trafione / n) * V_szescian;       // Szacowana objętość kuli
endfunction

// Test dla n = 1000
n1 = 1000;
V_mc_1000 = monte_carlo_kula(n1, k);
blad_1000 = abs(V_mc_1000 - V_dokladne);
disp("Dla n = 1000 prób:");
disp("  V_oszacowane = " + string(V_mc_1000));
disp("  Błąd bezwzględny = " + string(blad_1000));

// Test dla n = 10000
n2 = 10000;
V_mc_10000 = monte_carlo_kula(n2, k);
blad_10000 = abs(V_mc_10000 - V_dokladne);
disp(" ");
disp("Dla n = 10000 prób:");
disp("  V_oszacowane = " + string(V_mc_10000));
disp("  Błąd bezwzględny = " + string(blad_10000));

disp(" ");
disp("==============================================");
disp("ZADANIE 3: Porównanie z wartością dokładną");
disp("==============================================");
disp("Wartość dokładna V = " + string(V_dokladne));
disp("Błąd dla 1000  prób: " + string(blad_1000)  + " (" + string(blad_1000/V_dokladne*100) + "%)");
disp("Błąd dla 10000 prób: " + string(blad_10000) + " (" + string(blad_10000/V_dokladne*100) + "%)");

disp(" ");
disp("==============================================");
disp("ZADANIE 4: 10 powtórzeń × 1000 prób, uśrednione");
disp("==============================================");
liczba_powtorzen = 10;
wyniki = zeros(1, liczba_powtorzen); 

// Pętla 10 powtórzeń
for i = 1:liczba_powtorzen
    wyniki(i) = monte_carlo_kula(1000, k);
    disp("  Powtórzenie " + string(i) + ": V = " + string(wyniki(i)));
end

// Obliczenie średniej i błędu
V_srednia = mean(wyniki);
blad_srednia = abs(V_srednia - V_dokladne);
disp(" ");
disp("Średnia z 10 powtórzeń: V = " + string(V_srednia));
disp("Błąd bezwzględny: " + string(blad_srednia));
disp("Błąd procentowy: " + string(blad_srednia/V_dokladne*100) + "%");

disp(" ");
disp("==============================================");
disp("ZADANIE 5: Porównanie strategii");
disp("==============================================");
disp("Strategia A: 10 × 1000 prób (uśrednione)");
disp("  Wynik: " + string(V_srednia) + "  |  Błąd: " + string(blad_srednia));
disp(" ");
disp("Strategia B: 1 × 10000 prób");
disp("  Wynik: " + string(V_mc_10000) + "  |  Błąd: " + string(blad_10000));
disp(" ");

// Ocena efektywności strategii
if blad_srednia < blad_10000 then
    disp(">>> LEPSZA: Strategia A (10 × 1000) — uśrednianie zmniejsza losowe wahania");
else
    disp(">>> LEPSZA: Strategia B (1 × 10000) — większa próba daje mniejszy błąd");
end

// ============================================================
// WYKRESY
// ============================================================

// Przygotowanie danych do wykresów (Poprawione etykiety)
wartosci = [V_dokladne, V_srednia, V_mc_10000];
bledy = [0, blad_srednia, blad_10000];
etykiety = ["Dokladna", "10x1000", "1x10000"];
x = 1:3;

// Wykres 1: Porównanie objętości
figure(1); clf();
bar(x, wartosci);
title("Porównanie oszacowań objętości");
xlabel("Metoda"); ylabel("Objętość");
a = gca(); a.x_ticks = tlist(["ticks","locations","labels"], x, etykiety);
xgrid();

// Wykres 2: Porównanie błędów
figure(2); clf();
bar(x, bledy);
title("Porównanie błędów bezwzględnych");
xlabel("Metoda"); ylabel("Błąd bezwzględny");
a = gca(); a.x_ticks = tlist(["ticks","locations","labels"], x, etykiety);
xgrid();

disp(" ");
disp("==============================================");
disp("KONIEC");
disp("==============================================");
