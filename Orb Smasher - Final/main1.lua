--Constantes (valores que não mudam depois de atribuidos)
_H = display.contentHeight	-- Representa a altura do device em pixels
_W = display.contentWidth	-- Representa a largura do device em pixels
mRand = math.random	-- Biblioteca de randomizacao
o = 0; -- Controla a quantidade de esferas criadas
time_remain = 10 -- Tempo de execução restante do jogo
time_up = false	-- Controla o fim do jogo
total_orbs = 20 	-- Total de esferas geradas
ready = false		-- Controla o início do jogo
-- Prepara sons para ser executado ou acessados
--local soundtrack = audio.loadStream("media/soundtrack.caf");
local pop_sound = audio.loadSound("media/pop.wav")	-- Som da esfera estourada
local win_sound = audio.loadSound("media/win.wav")	-- Som da vitória
local fail_sound = audio.loadSound("media/fail.wav")	-- Som da derrota
--Função responsável pela criação das esferas
local function spawnOrb()
	local orb = display.newImageRect("images/blue_orb.png",45,45)
	orb.anchorX = .5
	orb.anchorY = .5
	-- Randomiza o posicionamento de cada esfera criada
	orb.x = mRand(50, _W-50)
	orb.y = mRand(50, _H-50)
end
-- Chama a função que cria as esferas
tmr = timer.performWithDelay(20, spawnOrb, total_orbs)