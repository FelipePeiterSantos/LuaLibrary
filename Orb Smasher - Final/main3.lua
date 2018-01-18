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

-- Cria uma caixa de texto para dar instruções ao jogador
local display_txt = display.newText( "Wait", 0, 0, native.systemFont, 16*2 )
display_txt.xScale = .5	-- Configura a escala x
display_txt.yScale = .5	-- Configura a escala y
display_txt.anchorX = .5
display_txt.anchorY = .5
display_txt.x = 20		-- Configura a posição x
display_txt.y = _H-20	-- Configura a posição y

-- Cria uma caixa de texto que exibe o tempo restante do jogo
local countdowntxt = display.newText(time_remain, 0, 0, native.systemFont, 16*2 )
countdowntxt.xScale = .5
countdowntxt.yScale = .5
countdowntxt.anchorX = .5
countdowntxt.anchorY = .5
countdowntxt.x = _W-20
countdowntxt.y = _H-20

local function trackOrbs(obj)
	obj:removeSelf()
end

local function countDown(e)
	time_remain = time_remain - 1
	countdowntxt.text = time_remain
end

local function spawnOrb()
	local orb = display.newImageRect("images/blue_orb.png",45,45)
	orb:setReferencePoint(display.CenterReferencePoint)
	orb.x = mRand(50, _W-50)
	orb.y = mRand(50, _H-50)
	
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
		return true	-- retorna true
	end
	-- Incrementa a variável "o" para toda esfera criada
	o = o + 1
	
	-- Adiciona o evento ao objeto
	--object:addEventListener( eventName, listener )
	orb:addEventListener ( "touch", orb)
	
	-- Se todas as esferas foram criadas, inicia o tempo do jogo
	if(o == total_orbs) then
		-- Instancia o timer que controla o tempo do jogo e chama a função countDown
		gametmr = timer.performWithDelay ( 1000, countDown, 10 )
	end
	
end
-- Chama a função que cria as esferas
tmr = timer.performWithDelay(20, spawnOrb, total_orbs)