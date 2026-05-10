-- ITEMS ----------------------------------------------------------------

core.register_craftitem("terras_capixabas:sidewalk", {
description = "Ande na Calcada",
inventory_image = "sidewalk.png"
})

core.register_craftitem("terras_capixabas:pincel", {
description = "Pincel",
inventory_image = "pincel.png"
})

-- BOOK

local pages = {
 "Bem Vindo ao Mod Terras Capixabas!\n\nEste guia te ensina como tudo funciona.\nUse as setas pra navegar nas páginas.",

 "-- INTRODUÇÃO:\n\n🌴 Terras Capixabas - O Mod Definitivo de Simulação da Vida Brasileira para Luanti\n\n🎯 O Que Torna Este Mod Especial?\n\nTerras Capixabas não é apenas mais um mod - é uma experiência cultural brasileira completa trazida à vida no Luanti! Esqueça mods genéricos de fantasia; esta é uma representação vibrante e viva da vida costeira do Espírito Santo.\n\n📊 Mod em Resumo:\n\n• 📁 1.488 arquivos de pura atmosfera brasileira\n\n• 🎵 5.026 KB de sons autênticos (ritmos de samba, vendedores ambulantes, pássaros tropicais)\n\n• 🖼️ 2.248 KB de texturas artesanais\n\n• 🎭 63 scripts Lua alimentando NPCs inteligentes e sistemas\n\n• 🚗 20 veículos únicos da clássica cultura automotiva brasileira\n\n🌟 Funcionalidades Únicas que o Diferem:\n\n🏝️ Ambiente Brasileiro Autêntico:\n\n• Ecossistemas costeiros com manguezais, coqueiros e flora tropical adequados\n\n• Arquitetura brasileira real - desde casas coloniais até propriedades modernas à beira-mar\n\n• Comidas e bebidas tradicionais - pastel, pão de queijo, caipirinha e muito mais!\n\n👥 Sistema de NPCs Vivos e Respirantes:\n\n• 100+ NPCs únicos com personalidades brasileiras\n\n• Sistema de comportamento inteligente - NPCs vagueiam, socializam, seguem rotinas\n\n• Personagens do folclore - Cuca, Saci, Curupira (criaturas míticas brasileiras)\n\n• Vendedores ambulantes - Picolé, pipoqueiros com chamados sonoros autênticos\n\n🚗 Cultura Automotiva Brasileira:\n\n• Carros clássicos: Fusca, Kombi, Brasília, Veraneio\n\n• Veículos de trabalho: Trator de esteira, caminhões basculantes, rolo compressor\n\n• Transporte público: Ônibus brasileiros autênticos\n\n• Veículos especiais: Carro alegórico de Carnaval, disco voador (sim, sério!)\n\n🏠 Espaços de Vida Completos:\n\n• Sistema de mobília detalhado com eletrodomésticos funcionais\n\n• Encanamento funcional - chuveiros, pias, privadas\n\n• Cozinhas realistas com fogões, geladeiras, máquinas de lavar\n\n• Sistemas de entretenimento - TVs antigas, rádios, máquinas de fliperama\n\n🎨 Excelência Técnica:\n\n• Arquitetura de código limpa com 4.492 linhas de Lua eficiente\n\n• Gerenciamento inteligente de dependências - sem dependências circulares\n\n• Estrutura de arquivos otimizada - pastas bem organizadas\n\n• Sistema profissional de sprites - 45+ poses e animações de NPCs\n\n🎮 Experiência de Jogo:\n\n• Ciclos dinâmicos dia/noite com comportamentos apropriados de NPCs\n\n• Mundo interativo - sente em cadeiras, deite em camas, use eletrodomésticos\n\n• Ecossistema animal - beija-flores, caranguejos, gaivotas, vagalumes\n\n• Sistema de construção - construa casas brasileiras autênticas\n\n• Objetos de rua - orelhões, semáforos, bancos de praça\n\n🛠️ Destaques Técnicos:\n\n📈 Qualidade do Código: 63 arquivos Lua (348 KB total)\n\n🎭 Sistema de NPCs: 9 arquivos principais com IA avançada\n\n🚗 Veículos: 20 implementações únicas\n\n🏠 Mobília: 1.538 KB de objetos interativos\n\n🎵 Áudio: 50+ sons brasileiros autênticos\n\n🎯 Por Que Este Mod Se Diferencia:\n\n1. Autenticidade cultural - Feito por brasileiros, para todos\n\n2. Polimento técnico - Código limpo, sem crashes, desempenho otimizado\n\n3. Mundo vivo - NPCs parecem reais com rotinas e interações\n\n4. Fidelidade visual - Modelos 3D e texturas de alta qualidade\n\n5. Imersão sonora - Paisagem sonora brasileira autêntica\n\n🌐 Perfeito Para:\n\n• Jogadores que desejam uma simulação de vida realista\n\n• Jogadores brasileiros com saudade de casa em outros jogos\n\n• Modders estudando sistemas avançados de Lua/NPCs\n\n• Qualquer pessoa cansada de mods genéricos de fantasia/medieval\n\n________________________________________\n\n🇧🇷 Terras Capixabas não é apenas um mod - é um portal para a vida costeira brasileira!\n\nExperimente os sons do samba, o sabor da água de coco fresca e o calor da hospitalidade brasileira - tudo dentro do Luanti.",

 "Locais da Vila Capixaba:\n\n- Clube: diversão Noturna na Vila\n- Shopping Center: o Shopping é novo e por isso tem pouca coisa\n- Praia: É o cartão postal da Vila!\n- Academia\n- Pizzaria\n- Mecânica\n- Elas Hotel\n- Loja de Emprego\n- Cemitério\n- igreja\n- Escola\n- Departamento de Polícia\n- Banco Capixabinha\n- Uma extensa favela no morro\n- Parquinho infantil e uma grande área Florestal com cachoeira",

 "A Fauna:\n\n- Cachorro: Te segue se segurar um espetinho de sacanagem na mão\n\n- Pássaros: Voam de dia e dormem de noite\nTemos a Araponga, a Rolinha, o Bem te Ví, o Pardal, o Periquito, o Pica Pau e o Beija Flor q voa bem rápido!\n\n- Tem um morcego q fica pendurado em uma árvore perto do cemitério! Ele dorme de dia e sai pra passear à noite\n- Galinha, galo e pintinho\n- Bichos noturnos como a mariposa, o grilo e o sapo\n- A lavadeira q fica voando por cima do brejo da Vila e o caranguejo q adora passear pelas areias da praia",

 "A Flora:\n\n- A Vila possui uma grande variedade de plantas tropicais! são tantas q n dá pra listar todas!",

 "Carros:\n- Os carros se dirigem igual, menos o disco voador.\n Pra decolar aperte Espaço e para descer aperte Shift. Pra sair, botão direito do mouse.\n\nVeículos disponíveis:\n- bicicleta_monark\n- boia_pneu\n- brasilia\n- brasilia_vendedora\n- bulldozer\n- cacamba\n- caminhazinho\n- carrinho_ferreo\n- carrinho_rolima\n- carro_carnavalesco\n- disco_voador\n- dodge_van\n- ford_landau\n- fumaca\n- fusca\n- jetski\n- kombi\n- kombi_carroceria\n- moto\n- onibus\n- rural\n- scania\n- steamroller\n- trem\n- veraneio",

 "Receitas:\n\n- Liquidificador: coloque: maçã, banana e leite pra fazer sua vitamina! O liquidificador só faz isso p enquanto\n\n- Microondas: só aceita pizza_congelada\n\n- Torradeira: só aceita pao_de_forma!\n\nFogão ou Fogão de Lenha:\n\nAntes de ligar o fogão, escolha os ingredientes no seu inventário.\nDepois vá até um fogão moderno ou fogão a lenha e interaja com ele para acendê-lo.\nAssim que estiver aceso, interaja novamente para abrir o menu de cozinha.\nColoque os ingredientes nos espaços da tela para o prato desejado e pressione o botão Cozinhar.\nSua comida ficará pronta em 3 segundos!\n\narroz + feijao ➡️ arroz com feijao\n\nbatata ➡️ batata_frita\n\ncamarao ➡️ camarao_frito\n\nfeijao + farinha + ovo ➡️ feijao_tropeiro\n\nfeijao + carne_de_porco ➡️ feijoada\n\npao + salsicha ➡️ cacorro_quente\n\npeixe + oleo + tempero_verde ➡️ moqueca_capixaba\n\npeixe + oleo + tomate ➡️ peroa_frito\n\novo ➡️ ovo_frito\n\ncaranguejo_vivo ➡️ pua_caranguejo\n\npeixe + oleo + batata ➡️ torta_bacalhau\n\nmacarrao + agua + tomate ➡️ macarronada"
}


core.register_craftitem("terras_capixabas:guide_book", {
 description = "Guia do Usuário",
 inventory_image = "mod_terras.png",
 stack_max = 1,

 on_use = function(itemstack, user, pointed_thing)
   local player_name = user:get_player_name()
   local page = 1

   local function show_page(p)
     local formspec = "size[8,6]"..
      "box[0,0;8,6;#0D5694]"

     local textarea_height = 5
     if p == 1 then textarea_height = 2 end
     formspec = formspec.."textarea[0.5,0.5;8,"..textarea_height..";;;"..core.formspec_escape(pages[p]).."]"

     if p == 1 then
       formspec = formspec.."image[0.4,2;3,2;screenshot.png]"
     end

     formspec = formspec..
      "image_button[0.2,5.2;1,0.8;gui_left_arrow.png;prev;;false;false;]"..
      "image_button[6.8,5.2;1,0.8;gui_right_arrow.png;next;;false;false;]"..
      "label[3.5,5.5;Página "..p.."]"

     core.show_formspec(player_name, "terras_capixabas:guia_usuario", formspec)
   end

   show_page(page)

   core.register_on_player_receive_fields(function(player, formname, fields)
     if player:get_player_name() ~= player_name then return end
     if formname ~= "terras_capixabas:guia_usuario" then return end
     if fields.prev then page = page - 1 if page < 1 then page = #pages end show_page(page) end
     if fields.next then page = page + 1 if page > #pages then page = 1 end show_page(page) end
   end)

   return itemstack
 end
})
