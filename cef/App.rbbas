#tag Class
Protected Class App
Inherits Application
	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Dim md As New MessageDialog
		  Dim trimmedStack() As String
		  trimmedStack = error.Stack
		  // Prepare the error dialog
		  md.Message = "Oops??"
		  md.Explanation = error.Message + EndOfLine + EndOfLine + _
		  "Please send this information to the developer." + EndOfLine + _
		  Join( trimmedStack, EndOfLine )
		  md.ActionButton.Caption = "Quit"
		  md.CancelButton.Caption = "Continue"
		  md.CancelButton.Visible = True
		  // if the user decided to quit, rather than tempt fate,
		  // we should quit.
		  If md.ShowModal = md.ActionButton Then
		    Quit
		  End If
		  
		  Return true
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileNewWIndow() As Boolean Handles FileNewWIndow.Action
			dim win as new DemoWindow
			win.Show
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileOpenFile() As Boolean Handles FileOpenFile.Action
			dim file as FolderItem = GetOpenFolderItem("")
			if file = nil then Return true
			
			dim stream as BinaryStream = BinaryStream.Open(file)
			if stream = nil then Return true
			
			dim tmp as new MemoryBlock(stream.Length)
			tmp.StringValue(0, stream.Length) = stream.Read(stream.Length)
			stream.Close
			
			dim encoding as TextEncoding = DemoWindow.GuessEncoding(tmp.StringValue(0, tmp.size))
			
			if encoding <> nil and not encoding.Equals(Encodings.UTF16) and not encoding.Equals(Encodings.UTF8) then encoding = nil
			
			dim w as new DemoWindow
			w.TestField.Text = tmp.StringValue(0, tmp.Size).defineEncoding(encoding)
			'w.TestField.ClearDirtyLines
			w.Show
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Constant, Name = AppName, Type = String, Dynamic = False, Default = \"CustomEditField Demo", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
