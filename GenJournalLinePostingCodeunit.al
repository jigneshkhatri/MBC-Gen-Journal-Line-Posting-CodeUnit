codeunit 50101 "Gen. Journal Line Posting"
{
    procedure PostGenJournalLine(genJournalLineID: Guid): Text
    var
        GenJournalLineRec: Record "Gen. Journal Line";

    begin
        // Find the Gen Journal Line based on the provided Guid
        if GenJournalLineRec.GetBySystemId(genJournalLineID) then begin

            // Post the Journal Line
            Codeunit.RUN(Codeunit::"Gen. Jnl.-Post", GenJournalLineRec);
            exit('Gen. Journal Line [Document Type=' + Format(GenJournalLineRec."Document Type") + ', Document No.= ' + GenJournalLineRec."Document No." + '] posted successfully.');

        end
        else begin
            Error('Gen. Journal Line not found.');
        end;
    end;

}