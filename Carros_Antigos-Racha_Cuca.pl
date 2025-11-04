% --- PREDICADOS ACESSORES ---
% carro(Cor, Ano, Montadora, Dono, Placa, Km)
cor(carro(C,_,_,_,_,_),C).
ano(carro(_,A,_,_,_,_),A).
montadora(carro(_,_,M,_,_,_),M).
dono(carro(_,_,_,D,_,_),D).
placa(carro(_,_,_,_,P,_),P).
km(carro(_,_,_,_,_,K),K).

% --- PREDICADOS AUXILIARES DE POSIÇÃO ---

algum_carro(X,solucao(X,_,_,_,_)).
algum_carro(X,solucao(_,X,_,_,_)).
algum_carro(X,solucao(_,_,X,_,_)).
algum_carro(X,solucao(_,_,_,X,_)).
algum_carro(X,solucao(_,_,_,_,X)).

exatamente_a_direita(X,Y,solucao(Y,X,_,_,_)).
exatamente_a_direita(X,Y,solucao(_,Y,X,_,_)).
exatamente_a_direita(X,Y,solucao(_,_,Y,X,_)).
exatamente_a_direita(X,Y,solucao(_,_,_,Y,X)).

exatamente_a_esquerda(X,Y,S) :-
    exatamente_a_direita(Y,X,S).

em_algum_lugar_entre(M,I,F,solucao(I,M,F,_,_)).
em_algum_lugar_entre(M,I,F,solucao(I,M,_,F,_)).
em_algum_lugar_entre(M,I,F,solucao(I,M,_,_,F)).
em_algum_lugar_entre(M,I,F,solucao(I,_,M,F,_)).
em_algum_lugar_entre(M,I,F,solucao(I,_,M,_,F)).
em_algum_lugar_entre(M,I,F,solucao(I,_,_,M,F)).
em_algum_lugar_entre(M,I,F,solucao(_,I,M,F,_)).
em_algum_lugar_entre(M,I,F,solucao(_,I,M,_,F)).
em_algum_lugar_entre(M,I,F,solucao(_,I,_,M,F)).
em_algum_lugar_entre(M,I,F,solucao(_,_,I,M,F)).

terceira_posicao(X,solucao(_,_,X,_,_)).

em_algum_lugar_a_esquerda(X,Y,solucao(X,Y,_,_,_)).
em_algum_lugar_a_esquerda(X,Y,solucao(X,_,Y,_,_)).
em_algum_lugar_a_esquerda(X,Y,solucao(X,_,_,Y,_)).
em_algum_lugar_a_esquerda(X,Y,solucao(X,_,_,_,Y)).
em_algum_lugar_a_esquerda(X,Y,solucao(_,X,Y,_,_)).
em_algum_lugar_a_esquerda(X,Y,solucao(_,X,_,Y,_)).
em_algum_lugar_a_esquerda(X,Y,solucao(_,X,_,_,Y)).
em_algum_lugar_a_esquerda(X,Y,solucao(_,_,X,Y,_)).
em_algum_lugar_a_esquerda(X,Y,solucao(_,_,X,_,Y)).
em_algum_lugar_a_esquerda(X,Y,solucao(_,_,_,X,Y)).

em_algum_lugar_a_direita(X,Y,S) :-
    em_algum_lugar_a_esquerda(Y,X,S).

ao_lado(X,Y,S) :-
    exatamente_a_esquerda(X,Y,S);
    exatamente_a_esquerda(Y,X,S).

uma_das_pontas(X,solucao(X,_,_,_,_)).
uma_das_pontas(X,solucao(_,_,_,_,X)).


% --- REGRA PRINCIPAL (SOLUÇÃO) ---

resolve(S) :-
    S = solucao(_,_,_,_,_), % Existem 5 carros na solução

    % 1. O carro da placa CCC-3333 está em algum lugar entre o carro Branco e o carro da placa DDD-4444, nessa ordem.
    em_algum_lugar_entre(A, B, C, S), 
    placa(A, 'CCC-3333'), 
    cor(B, 'Branco'), 
    placa(C, 'DDD-4444'),

    % 2. Glenn está exatamente à direita do carro de 140 mil Km.
    exatamente_a_direita(D, E, S), 
    dono(D, 'Glenn'), 
    km(E, '140 mil'),

    % 3. O veículo de 1960 tem 140 mil Km.
    algum_carro(F, S), 
    ano(F, '1960'), 
    km(F, '140 mil'),

    % 4. Harley está em uma das pontas.
    uma_das_pontas(G, S), 
    dono(G, 'Harley'),

    % 5. O carro Branco está em algum lugar entre o carro da Ford e o carro mais novo (1970), nessa ordem.
    em_algum_lugar_entre(H, I, J, S), 
    cor(H, 'Branco'), 
    montadora(I, 'Ford'), 
    ano(J, '1970'),

    % 6. O veículo de placa AAA-1111 está exatamente à esquerda do carro de 1955.
    exatamente_a_esquerda(K, L, S), 
    placa(K, 'AAA-1111'), 
    ano(L, '1955'),

    % 7. O veículo Amarelo está em algum lugar à esquerda do carro de 140 mil Km.
    em_algum_lugar_a_esquerda(M, N, S), 
    cor(M, 'Amarelo'), 
    km(N, '140 mil'),

    % 8. Na terceira posição está o carro da cor Verde.
    terceira_posicao(O, S), 
    cor(O, 'Verde'),

    % 9. O carro de 1955 está exatamente à esquerda do carro de placa BBB-2222.
    exatamente_a_esquerda(P, Q, S), 
    ano(P, '1955'), 
    placa(Q, 'BBB-2222'),

    % 10. O carro da Volkswagen está em algum lugar à direita do carro Vermelho.
    em_algum_lugar_a_direita(R, T, S), 
    montadora(R, 'Volkswagen'), 
    cor(T, 'Vermelho'),

    % 11. O veículo da Chevrolet está ao lado do veículo de 140 mil Km.
    ao_lado(U, V, S), 
    montadora(U, 'Chevrolet'), 
    km(V, '140 mil'),

    % 12. Em uma das pontas está o carro mais rodado (190 mil Km).
    % (Nota: A sua lista de Km [80, 100, 140, 190, 210] torna o '210 mil' o mais rodado)
    % (Vou seguir a pista 12 literalmente como "190 mil", pode ser uma pegadinha)
    uma_das_pontas(W, S), 
    km(W, '190 mil'),

    % 13. O carro Branco está em algum lugar entre o carro de 190 mil Km e o veículo da Porsche, nessa ordem.
    em_algum_lugar_entre(X, Y, Z, S), 
    cor(X, 'Branco'), 
    km(Y, '190 mil'), 
    montadora(Z, 'Porsche'),

    % 14. O veículo de placa AAA-1111 está exatamente à esquerda do carro da Mercedes.
    exatamente_a_esquerda(A1, B1, S), 
    placa(A1, 'AAA-1111'), 
    montadora(B1, 'Mercedes'),

    % 15. O carro Branco está em algum lugar à esquerda do veículo de 100 mil Km.
    em_algum_lugar_a_esquerda(C1, D1, S), 
    cor(C1, 'Branco'), 
    km(D1, '100 mil'),

    % 16. Ponce é o dono do carro da placa EEE-5555.
    algum_carro(E1, S), 
    dono(E1, 'Ponce'), 
    placa(E1, 'EEE-5555'),

    % 17. O carro de 140 mil Km está em algum lugar à direita do carro Branco.
    em_algum_lugar_a_direita(F1, G1, S), 
    km(F1, '140 mil'), 
    cor(G1, 'Branco'),

    % 18. Thales está em algum lugar entre o carro de 1970 e o Glenn, nessa ordem.
    em_algum_lugar_entre(H1, I1, J1, S), 
    dono(H1, 'Thales'), 
    ano(I1, '1970'), 
    dono(J1, 'Glenn'),

    % 19. O veículo da Chevrolet está em algum lugar à direita do carro de 1965.
    % (!!! CORREÇÃO FEITA AQUI: Mudei 1963 para 1965 para bater com sua lista)
    em_algum_lugar_a_direita(K1, L1, S), 
    montadora(K1, 'Chevrolet'), 
    ano(L1, '1965'),

    % --- Fechamento CORRIGIDO ---
    % Itens restantes que não foram mencionados nas pistas, 
    % baseados na sua nova lista:
    
    % Cor: 'Azul' (amarelo, branco, verde, vermelho foram mencionados)
    algum_carro(M1, S), cor(M1, 'Azul'),
    
    % Ano: '1950' (1955, 1960, 1965, 1970 foram mencionados)
    algum_carro(M2, S), ano(M2, '1950'),
    
    % Dono: 'Aguiar' (Glenn, Harley, Ponce, Thales foram mencionados)
    algum_carro(M3, S), dono(M3, 'Aguiar'),
    
    % Kms: '80 mil' e '210 mil' (100 mil, 140 mil, 190 mil foram mencionados)
    algum_carro(M4, S), km(M4, '80 mil'),
    algum_carro(M5, S), km(M5, '210 mil').