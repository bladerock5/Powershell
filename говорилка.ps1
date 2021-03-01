#говорилка
function Run1C
{
	Add-Type -AssemblyName System.Speech
$voice = New-Object System.Speech.Synthesis.SpeechSynthesizer
$voice.Speak("В системе может быть установлено несколько голосов ― есть варианты разных национальностей, возрастов и полов, каждый со своим именем. Посмотреть общий список можно командой:
$voice.GetInstalledVoices().VoiceInfo")
}
Run1C