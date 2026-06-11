import QtQuick 2.0
import QtQuick.Controls 2.2
import MuseScore 3.0

MuseScore {
      
      menuPath: "ColouredNotesTDS"
      description: "This Plugin colours the notes in a composition based on the chosen system."
      pluginType: "dialog"
      version: "1.0"
      
      width:  500 
      height: 630
      id: mainWindow
      
      function coloranote(nomesistema) {
            labelResult.text =  "Notes coloured following " + nomesistema + "'s system.";
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
            id: newton
            text: "SoundQuestTDS1"
            anchors.left: mainWindow.left        	
            anchors.top: mainWindow.top        	
            anchors.leftMargin: 10        	
            anchors.topMargin: 10
            onClicked: {
                  coloranote("Newton")
                  }
            }
        
      RadioButton {
            id: castel
            text: "SoundQuestTDS2"
            anchors.left: newton.left        	
            anchors.top: newton.bottom
            onClicked: {
                  coloranote("Castel")
                  }
            }
                  
      RadioButton {
            id: field
            text: "SoundQuestTDS3"
            anchors.left: castel.left        	
            anchors.top: castel.bottom
            onClicked: {
                  coloranote("Field")
                  }
            }
            
      RadioButton {
            id: jameson
            text: "AccessibleTDS1"
            anchors.left: field.left        	
            anchors.top: field.bottom
            onClicked: {
                  coloranote("Jameson")
                  }
            }
      
      RadioButton {
            id: helmholtz
            text: "AccessibleTDS2"
            anchors.left: jameson.left        	
            anchors.top: jameson.bottom
            onClicked: {
                  coloranote("Helmholtz")
                  }
            }
            
      RadioButton {
            id: bishop
            text: "AccessibleTDS3"
            anchors.left: helmholtz.left        	
            anchors.top: helmholtz.bottom
            onClicked: {
                  coloranote("Bishop")
                  }
            }
      
      Button {
            id: buttonRestore
            text: "Reset"

            anchors.left: bishop.left        	
            anchors.top: bishop.bottom 
            anchors.topMargin: 10
                        
            onClicked: {
                 coloranote("default")
	          } 
            }      
                
      Button {
            id: exit
            text: "Exit"
            
            anchors.right: mainWindow.right        	
            anchors.bottom: mainWindow.bottom 
            anchors.bottomMargin: 50
            anchors.rightMargin: 10
                        
            onClicked: {
                 Qt.quit()
	          } 
            }  
                 
      Label {
            id: labelResult	
            anchors.left: buttonRestore.left        	
            anchors.top: buttonRestore.bottom       	
            anchors.topMargin: 10
            }

      onRun: {
            coloranote("default")
            }
      }
