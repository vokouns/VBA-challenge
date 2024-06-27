Sub yearlyStock()
    Dim total As Double
    Dim i As Double
    Dim j As Integer
    Dim change As Double
    Dim start As Long
    Dim rowcount As Long
    Dim percentChange As Double
    Dim dailyChange As Single
    Dim averageChange As Double
    Dim ws As Worksheet
    
    For Each ws In Worksheets
        j = 0
        total = 0
        change = 0
        start = 2
        dailyChange = 0
        
        ws.Range("I1").Value = "Ticker"
        ws.Range("J1").Value = "Quarterly Change"
        ws.Range("K1").Value = "Percent Change"
        ws.Range("L1").Value = "Total Stock Volume"
        ws.Range("o2").Value = "Greatest % Increase"
        ws.Range("O3").Value = "Greatest % Decrease"
        ws.Range("o4").Value = "Greatest Total Volume"
        ws.Range("p1").Value = "Ticker"
        ws.Range("q1").Value = "Value"
        
        rowcount = ws.Cells(Rows.Count, "A").End(xlUp).Row
        
        For i = 2 To rowcount
        
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                
                total = total + ws.Cells(i, 7).Value
                
                If total = 0 Then
                
                ws.Range("I" & 2 + j).Value = Cells(i, 1).Value
                ws.Range("J" & 2 + j).Value = 0
                ws.Range("K" & 2 + j).Value = "%" & 0
                ws.Range("L" & 2 + j).Value = 0
            Else
                If ws.Cells(start, 3).Value = 0 Then
                    For find_value = start To i
                        If ws.Cells(find_value, 3).Value <> 0 Then
                        start = find_value
                        Exit For
                    End If
                Next find_value
            End If
            
            change = (ws.Cells(i, 6) - ws.Cells(start, 3))
            percentChange = change / ws.Cells(start, 3)
            
            
            start = i + 1
            
            ws.Range("I" & 2 + j) = ws.Cells(i, 1).Value
            ws.Range("J" & 2 + j) = change
            ws.Range("J" & 2 + j).NumberFormat = "0.00"
            ws.Range("K" & 2 + j).Value = percentChange
            ws.Range("K" & 2 + j).NumberFormat = "0.00%"
            ws.Range("L" & 2 + j).Value = total
            
            Select Case change
                Case Is > 0
                    ws.Range("J" & 2 + j).Interior.ColorIndex = 4
                Case Is < 0
                    ws.Range("J" & 2 + j).Interior.ColorIndex = 3
                Case Else
                    ws.Range("J" & 2 + j).Interior.ColorIndex = 0
                    
            End Select
            
        End If
        
        total = 0
        change = 0
        j = j + 1
        Days = 0
        dailyChange = 0
        
        
    Else
        total = total + ws.Cells(i, 7).Value
        
    End If
Next i

ws.Range("Q2") = "%" & WorksheetFunction.Max(ws.Range("k2:k" & i)) * 100
ws.Range("Q3") = "%" & WorksheetFunction.Min(ws.Range("k2:k" & i)) * 100
ws.Range("Q4") = WorksheetFunction.Max(ws.Range("L2:L" & i))

increase_number = WorksheetFunction.Match(WorksheetFunction.Max(ws.Range("K2:K" & i)), ws.Range("K2:K" & i), 0)
decrease_number = WorksheetFunction.Match(WorksheetFunction.Min(ws.Range("K2:K" & i)), ws.Range("K2:K" & i), 0)
volume_number = WorksheetFunction.Match(WorksheetFunction.Max(ws.Range("L2:L" & i)), ws.Range("L2:L" & i), 0)

ws.Range("P2") = ws.Cells(increase_number + 1, 9)
ws.Range("P3") = ws.Cells(decrease_number + 1, 9)
ws.Range("P4") = ws.Cells(volume_number + 1, 9)


Next ws
            
    
    
    
End Sub

