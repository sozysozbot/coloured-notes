import QtQuick 2.0
import QtQuick.Controls 2.2
import MuseScore 3.0

MuseScore {
      
      menuPath: "ColouredNotesAxisTDS"
      description: "This plugin colours the notes based on the axis system, where the colors for tonic, dominant, and subdominant notes are taken from SoundQuest."
      pluginType: "dialog"
      version: "1.0"
      
      width:  500 
      height: 300
      id: mainWindow
      
      function coloranote(nomesistema, explain) {
            labelResult.text =  "Click a note after selecting the radio button to colour all the notes " + explain + ".";
            var NoteNere = ["#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000", "#000000"]
            var Newton =    ["#49B656", "#F15031", "#F1AB31", "#49B656", "#F15031", "#F1AB31", "#49B656", "#F15031", "#F1AB31", "#49B656", "#F15031", "#F1AB31"]
            var Castel =    ["#F15031", "#F1AB31", "#49B656", "#F15031", "#F1AB31", "#49B656", "#F15031", "#F1AB31", "#49B656", "#F15031", "#F1AB31", "#49B656"]
            var Field =     ["#F1AB31", "#49B656", "#F15031", "#F1AB31", "#49B656", "#F15031", "#F1AB31", "#49B656", "#F15031", "#F1AB31", "#49B656", "#F15031"]
            var Jameson =   ["#4096FF", "#5701E1", "#F1AB31", "#4096FF", "#5701E1", "#F1AB31", "#4096FF", "#5701E1", "#F1AB31", "#4096FF", "#5701E1", "#F1AB31"]
            var Helmholtz = ["#5701E1", "#F1AB31", "#4096FF", "#5701E1", "#F1AB31", "#4096FF", "#5701E1", "#F1AB31", "#4096FF", "#5701E1", "#F1AB31", "#4096FF"]
            var Bishop =    ["#F1AB31", "#4096FF", "#5701E1", "#F1AB31", "#4096FF", "#5701E1", "#F1AB31", "#4096FF", "#5701E1", "#F1AB31", "#4096FF", "#5701E1"]
            var startStaff = 0
            var endStaff = curScore.nstaves - 1
            var startTick = 0
            var endTick
            
            var cursor = curScore.newCursor()
            cursor.rewind(1)
            
            if (cursor.segment) {
                  startStaff = cursor.staffIdx
                  startTick = cursor.tick
                  cursor.rewind(2)
                  if (cursor.tick != 0)
                        endTick = cursor.tick
                  else
                        endTick = curScore.lastSegment.tick + 1
                        endStaff = cursor.staffIdx
                  }
            else
                  endTick = curScore.lastSegment.tick + 1
                  
            for (var s = startStaff; s <= endStaff; s++)
                  for (var v = 0; v < 4; v++) {
                        cursor.staffIdx = s
                        cursor.voice = v
                        cursor.rewind(0)
                        
                        if (!cursor.element)
                              break
                        
                        while (cursor.tick < startTick)
                              cursor.next()
                        
                        do {
                              if (cursor.element.type == Element.CHORD)
                                   for (var i = 0; i < cursor.element.notes.length; i++) {
                                   switch(nomesistema) {
                                    case "default":
                                          cursor.element.notes[i].color = NoteNere[cursor.element.notes[i].pitch % 12]
                                          if (cursor.element.notes[i].accidental) {
                                                cursor.element.notes[i].accidental.color = NoteNere[cursor.element.notes[i].pitch % 12]
                                          }
                                                 break ;
                                    case "Newton":
                                          cursor.element.notes[i].color = Newton[cursor.element.notes[i].pitch % 12]
                                          if (cursor.element.notes[i].accidental) {
                                                cursor.element.notes[i].accidental.color = Newton[cursor.element.notes[i].pitch % 12]
                                          }
                                                 break ;
                                    case "Castel":
                                          cursor.element.notes[i].color = Castel[cursor.element.notes[i].pitch % 12]  
                                          if (cursor.element.notes[i].accidental) {
                                                cursor.element.notes[i].accidental.color = Castel[cursor.element.notes[i].pitch % 12]
                                          }
                                                 break ;
                                    case "Field":
                                          cursor.element.notes[i].color = Field[cursor.element.notes[i].pitch % 12]
                                          if (cursor.element.notes[i].accidental) {
                                                cursor.element.notes[i].accidental.color = Field[cursor.element.notes[i].pitch % 12]
                                          }
                                                 break ;
                                    case "Jameson":
                                          cursor.element.notes[i].color = Jameson[cursor.element.notes[i].pitch % 12]
                                          if (cursor.element.notes[i].accidental) {
                                                cursor.element.notes[i].accidental.color = Jameson[cursor.element.notes[i].pitch % 12]
                                          }
                                                 break ;
                                    case "Helmholtz":
                                          cursor.element.notes[i].color = Helmholtz[cursor.element.notes[i].pitch % 12] 
                                          if (cursor.element.notes[i].accidental) {
                                                cursor.element.notes[i].accidental.color = Helmholtz[cursor.element.notes[i].pitch % 12]
                                          } 
                                                 break ;
                                    case "Bishop":
                                          cursor.element.notes[i].color = Bishop[cursor.element.notes[i].pitch % 12]
                                          if (cursor.element.notes[i].accidental) {
                                                cursor.element.notes[i].accidental.color = Bishop[cursor.element.notes[i].pitch % 12]
                                          } 
                                                 break ;                                                                                                                     
                                                 }                            
                                        }
                            }
                        while (cursor.next() && cursor.tick < endTick)
                        }
            }

      RadioButton {
            id: nocolor
            text: "No Color"
            anchors.left: mainWindow.left        	
            anchors.top: mainWindow.top        	
            anchors.leftMargin: 10        	
            anchors.topMargin: 10
            onClicked: {
                  coloranote("default", "in the default color")
                  }
            }
                            
      RadioButton {
            id: tds1
            text: "SoundQuestTDS1: Tonic [C, Eb, F#, A] in green"
            anchors.left: nocolor.left        	
            anchors.top: nocolor.bottom    
            onClicked: {
                  coloranote("Newton", "following SoundQuest's color palette. Tonic [C, Eb, F#, A] are marked in green; Subdominant [D, F, Ab, B] in orange; Dominant [E, G, Bb, C#] in red")
                  }
            }
        
      RadioButton {
            id: tds2
            text: "SoundQuestTDS2: Tonic [D, F, Ab, B] in green"
            anchors.left: tds1.left        	
            anchors.top: tds1.bottom
            onClicked: {
                  coloranote("Castel", "following SoundQuest's color palette. Tonic [D, F, Ab, B] are marked in green; Subdominant [E, G, Bb, C#] in orange; Dominant [C, Eb, F#, A] in red")
                  }
            }
                  
      RadioButton {
            id: tds3
            text: "SoundQuestTDS3: Tonic [E, G, Bb, C#] in green"
            anchors.left: tds2.left        	
            anchors.top: tds2.bottom
            onClicked: {
                  coloranote("Field", "following SoundQuest's color palette. Tonic [E, G, Bb, C#] are marked in green; Subdominant [C, Eb, F#, A] in orange; Dominant [D, F, Ab, B] in red")
                  }
            }
            
      RadioButton {
            id: tdsacc1
            text: "AccessibleTDS1: Tonic [C, Eb, F#, A] in cyan"
            anchors.left: tds3.left        	
            anchors.top: tds3.bottom
            onClicked: {
                  coloranote("Jameson", "following SoundQuest's accessible color palette. Tonic [C, Eb, F#, A] are marked in cyan; Subdominant [D, F, Ab, B] in orange; Dominant [E, G, Bb, C#] in purple")
                  }
            }
      
      RadioButton {
            id: tdsacc2
            text: "AccessibleTDS2: Tonic [D, F, Ab, B] in cyan"
            anchors.left: tdsacc1.left        	
            anchors.top: tdsacc1.bottom
            onClicked: {
                  coloranote("Helmholtz", "following SoundQuest's accessible color palette. Tonic [D, F, Ab, B] are marked in cyan; Subdominant [E, G, Bb, C#] in orange; Dominant [C, Eb, F#, A] in purple")
                  }
            }
            
      RadioButton {
            id: tdsacc3
            text: "AccessibleTDS3: Tonic [E, G, Bb, C#] in cyan"
            anchors.left: tdsacc2.left        	
            anchors.top: tdsacc2.bottom
            onClicked: {
                  coloranote("Bishop", "following SoundQuest's accessible color palette. Tonic [E, G, Bb, C#] are marked in cyan; Subdominant [C, Eb, F#, A] in orange; Dominant [D, F, Ab, B] in purple")
                  }
            }   
                 
      Label {
            id: labelResult	
            width: mainWindow.width - 20
            anchors.left: tdsacc3.left        	
            anchors.top: tdsacc3.bottom       	
            anchors.topMargin: 10
            wrapMode: Text.WordWrap 
            }

      onRun: {
            coloranote("default", "in the default color")
            }
      }
