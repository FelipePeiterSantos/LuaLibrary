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
--display_txt:setReferencePoint(display.BottomLeftReferencePoint); -- Seta o ponto de referência do objeto
display_txt.anchorX = .5
display_txt.anchorY = .5
display_txt.x = 20			-- Configura a posição x
display_txt.y = _H-20	  -- Configura a posição y
-- Cria uma caixa de texto que exibe o tempo restante do jogo
local countdowntxt = display.newText(time_remain, 0, 0, native.systemFont, 16*2 )
countdowntxt.xScale = .5
countdowntxt.yScale = .5
--countdowntxt:setReferencePoint(display.BottomRightReferencePoint);
countdowntxt.anchorX = .5
countdowntxt.anchorY = .5
countdowntxt.x = _W-20
countdowntxt.y = _H-20

--Função que atualiza o status do jogo: vitória ou derrota
local function winLose(condition)
	if(condition == "win") then
		display_txt.text = "WIN!"
	elseif (condition == "fail") then
		display_txt.text = "FAIL!"
	end
end

local function trackOrbs(obj)
	obj:removeSelf() --Remove a esfera e libera memória
	o = o-1 --Decrementa o número de esferas existentes
	if(time_up ~= true) then --Teste se o tempo de jogo está ativo
		if(o == 0)then --Testa se o número de esferas zerou
			audio.play(win_sound) --Executa o som da vitória
			timer.cancel(gametmr) --Cancela o timer do jogo
			winLose("win") --Chama a função para atualizar o status do jogo
		end
	end
end

local function countDown(e)
	if(time_remain == 10) then --Testa se o tempo restante é 10s
		ready = true --Inicia o jogo
		display_txt.text = "Go!" --Atualiza o status do jogo
		--audio.play(soundtrack, {loops=-1}); --Executa o som de ambiente do jogo
	end
	time_remain = time_remain - 1 --Decrementa o tempo do jogo
	countdowntxt.text = time_remain --Atualiza o timer do tempo restante
	
	if(time_remain == 0) then --Testa se o tempo restante esgotou
		time_up = true --Tempo esgotado
		if(o ~= 0) then --Testa se o número de esferas é diferente de zero
			audio.play(fail_sound) --Executa o som da derrota
			winLose("fail") --Chama a função para atualizar o status do jogo
			ready = false
		end
	end
end
--Função responsável pela criação das esferas
local function spawnOrb()
	local orb = display.newImageRect("images/blue_orb.png",45,45)
	orb.x = mRand(50, _W-50)
	orb.y = mRand(50, _H-50)
	orb.anchorX = .5
	orb.anchorY = .5
	function orb:touch(e)
		if(ready == true) then
			if(time_up ~= true) then
				if(e.phase == "ended") then
					-- Toca o som
					audio.play(pop_sound)
					-- Remove a esfera
					trackOrbs(self)
				end
			end
		end
		return true
	end
	-- Incrementa a variável "o" para toda esfera criada
	o = o + 1
	-- Vincula o evento "touch" ao objeto orb
	orb:addEventListener ( "touch", orb)
	-- Testa se todas as esferas foram criadas
	if(o == total_orbs) then
		gametmr = timer.performWithDelay ( 1000, countDown, 10 ) --inicia o tempo do jogo
	else
		ready = false
	end
end
-- Chama a função que cria as esferas
tmr = timer.performWithDelay(20, spawnOrb, total_orbs)