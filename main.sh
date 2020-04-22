#!/bin/bash

sudo apt-get install yad; clear;

FORM=$(																\
	yad --center --title="Formulario de criação do Atalho" 			\
		--text="Preencha todos os dados" --text-align="center"		\
		--form 														\
		--field="Nome do atalho :" ""								\
		--field="Descrição :" ""									\
		--buton gtk-add --buttons-layout="center"					\

)

#passando o nome do atalho para criação do arquivo de configuração
echo $FORM > atalho.conf;
name=$(cut -d"|" -f1 ./atalho.conf);
echo $name;
touch "$name".desktop;
echo "[Desktop Entry]" >> "$name".desktop;

#passando o dado Name para o arquivo
echo "Name=${name}" >> "$name".desktop;

#passando o comentario para o arquivo
comment=$(cut -d"|" -f2 ./atalho.conf);
echo "Comment=$comment" >> "$name".desktop;

#passando o path de execução do arquivo
exec=$(yad --file --title="Escolha o arquivo para o atalho" --width="800" --height="500");
echo "Exec=$exec" >> "$name".desktop;

#selecionando o arquivo da imagem

Imagem=$(yad --file --title "Escolha seu icone" --width="800" --height="500");
echo "Icon=$Imagem" >> "$name".desktop

konsole=$(yad --center --yesno --title="Deseja que o script abra o terminal?" --width="400" --height="200");
if [ $? -eq 0 ] 
then 
	echo "Terminal=true" >> "$name".desktop;
else
	echo "Terminal=false" >> "$name".desktop;
fi

echo "Type=Application" >> "$name".desktop;
echo "Name[en_US]=$name" >> "$name".desktop;
echo "Name[pt_US]=$name" >> "$name".desktop;

chmod +x "$name".desktop;

localSave=$(yad --file --directory --title="Escolha o local para salvar o arquivo" --width="800" --height="400")
mv "$name".desktop $localSave;


