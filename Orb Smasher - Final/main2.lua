--Constantes (valores que não mudam depois de atribuidos)
_H = display.contentHeight	-- Representa a altura do device em pixels
_W = display.contentWidth	-- Representa a largura do device em pixels
mRand = math.random	-- Biblioteca de randomizacao
o = 0 -- Controla a quantidade de esferas criadas
time_remain = 10 -- Tempo de execução restante do jogo
time_up = false	-- Controla o fim do jogo
total_orbs = 20 	-- Total de esferas geradas
ready = false		-- Controla o início do jogo
-- Prepara sons para ser executado ou acessados
--local soundtrack = audio.loadStream("media/soundtrack.caf");
local pop_sound = audio.loadSound("media/pop.wav")	-- Som da esfera estourada
local win_sound = audio.loadSound("media/win.wav")	-- Som da vitória
local fail_sound = audio.loadSound("media/fail.wav")	-- Som da derrota

--Função que remove as esferas estourados (obj)
local function trackOrbs(obj)
	obj:removeSelf()
end
--Função responsável pela criação das esferas
local function spawnOrb()
	local orb = display.newImageRect("images/blue_orb.png",45,45)
	orb.anchorX = .5
	orb.anchorY = .5
	orb.x = mRand(50, _W-50); orb.y = mRand(50, _H-50)
	--Função que executa o evento de toque
	function orb:touch(e)
		-- Testa se o estado do toque é "ended"
		--began - indica que um dedo tocou a tela.
		--moved - indica que um dedo foi movido na tela.
		--ended- indica um dedo foi levantado a partir da tela.
		--cancelled - indica que o sistema cancelou o rastreamento do toque.
		if(e.phase == "ended") then
			-- Executa o som do estouro 
			audio.play(pop_sound)
			-- Remove a esfera
			trackOrbs(self)
		end
		return true
	end
	-- Adiciona o evento ao objeto
	--object:addEventListener( eventName, listener )
	orb:addEventListener ( "touch", orb)
end
-- Chama a função que cria as esferas
tmr = timer.performWithDelay(20, spawnOrb, total_orbs)