// Specification JFlex
import java_cup.runtime.Symbol;

%%
%unicode
%cup
%line
%column
//%debug


%{
	public int getYyLine(){
		return yyline+1;
	}
	public int getYyColumn(){
		return yycolumn+1;
	}
	public String getYyText(){
		return yytext();
	}
%}

// qqs exemples de macros...

TYPE_APPAREIL 					= "eclairage" | "volet" | "fenetre" | "chauffage" | "alarme" |"tv" | "hifi" | "cafetiere"
								| "video_proj" | "lave_vaisselle" | "lave_linge" | "seche_linge" | "ordinateur" | "portail" 
ETAT_APPAREIL 					= "allume" | "eteint" | "demi" |"eco" | "ouvert" | "ferme"

ACTION_APPAREIL 				= "allumer" | "eteindre" | "tamiser" | "allumer_partiel" | "allumer_eco" | "ouvrir"
 								| "fermer" |"ouvrir_partiel" | "fermer_partiel"
TYPE_INTERFACE 					= "interrupteur" | "mobile" | "telephone" | "tablette" | "telecommande"

pg ="("
pd =")"
accolade_g ="{"
accolade_d ="}"
virgule=","
point="."
deux_point=":"
point_virgule= ";"
affect = "="
egalite= "=="
underscore = "_"
crochet_fermant = ">"
entier = [0-9]+
ident = [a-zA-Z_]+[a-zA-Z0-9_]*
chaine = \"[^\"\n]*\"
commentaire = "//".*\n
espace = " "
finligne = "\t\n"

%%
// qqs exemples de r�gles lexicales l�gales...
{TYPE_APPAREIL}					{return new Symbol(sym.TYPE_APPAREIL, new String( yytext())); }
{ETAT_APPAREIL}					{return new Symbol(sym.ETAT_APPAREIL, new String( yytext())); }
{ACTION_APPAREIL}				{return new Symbol(sym.ACTION_APPAREIL, new String( yytext())); }
{TYPE_INTERFACE}				{return new Symbol(sym.TYPE_INTERFACE, new String( yytext())); }
"<PROGRAMME_DOMUS>"				{return new Symbol(sym.PROGRAMME_DOMUS_DEBUT , yytext()); }
"</PROGRAMME_DOMUS>"			{return new Symbol(sym.PROGRAMME_DOMUS_FIN , yytext()); }
"<DECLARATION_APPAREILS>"		{return new Symbol(sym.DEC_APPAREILS_DEBUT , yytext()); }
"</DECLARATION_APPAREILS>"		{return new Symbol(sym.DEC_APPAREILS_FIN , yytext()); }
"<DECLARATION_INTERFACES>"		{return new Symbol(sym.DEC_INTERFACES_DEBUT , yytext()); }
"</DECLARATION_INTERFACES>"		{return new Symbol(sym.DEC_INTERFACES_FIN , yytext()); }
"<DECLARATION_SCENARII>"		{return new Symbol(sym.DEC_SCENARII_DEBUT , yytext()); }
"</DECLARATION_SCENARII>"		{return new Symbol(sym.DEC_SCENARII_FIN , yytext()); }
"<DECLARATION_COMMANDES>"		{return new Symbol(sym.DEC_COMMANDES_DEBUT , yytext()); }
"</DECLARATION_COMMANDES>"		{return new Symbol(sym.DEC_COMMANDES_FIN , yytext()); }
"<SCENARIO"						{return new Symbol(sym.DEC_SCENARIO_DEBUT , yytext()); }
"</SCENARIO"					{return new Symbol(sym.DEC_SCENARIO_FIN , yytext()); }
"etat"							{return new Symbol(sym.ETAT , yytext()); }
"autre_appareil"				{return new Symbol(sym.AUTRE_APPAREIL , yytext()); }
"definir" 			        	{return new Symbol(sym.DEFINIR , yytext()); } 
"executer" 			        	{return new Symbol(sym.EXECUTER , yytext()); }
"executer_scenario" 			{return new Symbol(sym.EXECUTER_SCENARIO , yytext()); }
"associer"         				{return new Symbol(sym.ASSOCIER , yytext()); }
"programmer"        {return new Symbol(sym.PROGRAMMER , yytext()); }
"message"         	{return new Symbol(sym.MESSAGE , yytext()); }
"pourtout"          {return new Symbol(sym.POURTOUT , yytext()); }
"faire"         	{return new Symbol(sym.FAIRE , yytext()); }
"fait"         		{return new Symbol(sym.FAIT , yytext()); }
"si"         		{return new Symbol(sym.SI , yytext()); }
"alors"         	{return new Symbol(sym.ALORS , yytext()); }
"sinon"         	{return new Symbol(sym.SINON , yytext()); }
"fsi"         		{return new Symbol(sym.FINSI , yytext()); }
"!"         		{return new Symbol(sym.POINTEXCLAMATION , yytext()); }
""\"         		{return new Symbol(sym.GUILLEMET, new String( yytext())); }

{entier} 				  { return new Symbol(sym.ENTIER, new Integer(yytext())); }
{underscore} 			  {return new Symbol(sym.UNDERSCORE);}
{chaine} 			  	  {return new Symbol(sym.CHAINE, new String(yytext()));  }
{ident} 				  { return new Symbol(sym.IDENT , new String(yytext())); }
{espace} 				  {}
{finligne} 				  {} 
{commentaire} 		      {} 
{pg} 					  {return new Symbol(sym.PG);}
{pd} 					  {return new Symbol(sym.PD);}
{accolade_d} 			  {return new Symbol(sym.ACCOLADE_D);}
{accolade_g} 			  {return new Symbol(sym.ACCOLADE_G);}
{virgule} 				  {return new Symbol(sym.VIRGULE);}
{point_virgule}			  {return new Symbol(sym.POINTVIRGULE);}
{deux_point} 			  {return new Symbol(sym.DEUXPOINTS);}
{point} 				  {return new Symbol(sym.POINT);}

{egalite} 				  {return new Symbol(sym.EGALE);}
{affect}  				  {return new Symbol(sym.AFFECT);}
{crochet_fermant} 		  {return new Symbol(sym.CROCHET_FERMANT);}


// exemple de r�gle de d�tection d'erreurs lexicales...
{commentaire} {}

[" " | \t | \n] {}
.  {System.out.println(" Erreur ligne "+(yyline+1)+" colonne "+(yycolumn+1)+" : "+ yytext()+" => caractère inconnu ! "); } 


