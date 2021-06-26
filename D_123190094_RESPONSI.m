clear; 

opts = detectImportOptions('Real_estate_data.xlsx');
opts.SelectedVariableNames = (3:8);
datamatrix = readmatrix('Real_estate_data.xlsx', opts);
data1 = datamatrix(1:50,1:3);
data2 = datamatrix(1:50,6);
matrix = [data1 data2];

x = matrix; %data rating kecocokan dari masing-masing alternatif
k = [0,0,1,0]; %atribut tiap kriteria, dimana nilai 1=atrribut keuntungan, dan 0= atribut biaya
w = [3,5,4,1]; %Nilai bobot tiap kriteria

%Perbaikan bobot
[m n] = size (x); %inisialisasi ukuran x
w = w./sum(w); %pembagian bobot per kriteria dengan jumlah total seluruh bobot

%Melakukan perhitungan vektor(S) per baris (alternatif)
for j = 1:n,
    if k(j) == 0, w(j) = -1*w(j);
    end;
end;
for i = 1:m,
    S(i) = prod(x(i,:).^w);
end;

%Proses perangkingan
V = S/sum(S);
disp("Data Real Estate : ");
disp(matrix);

for q = 1:m;
    if V(q) == max(V)
        disp("Real estate yang menjadi pilihan terbaik untuk investasi jangka panjang adalah ke-" + q);
        disp("Dengan nilai " + max(V));
    end;
end;

VTranspose = V.';
opts = detectImportOptions('Real_estate_data.xlsx');
opts.SelectedVariableNames = (1);
y = readmatrix('Real_estate_data.xlsx',opts);
y = y(1:50,:);
y = [y VTranspose];
y = sortrows(y,-2);
y = y(1:5,1);

disp ("5 Real Estate yang menjadi pilihan terbaik : ")
disp (y)
