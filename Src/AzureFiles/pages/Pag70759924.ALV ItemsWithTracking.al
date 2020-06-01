page 70759924 "ALV ItemsWithTracking"
{
    PageType = API;
    Caption = 'ALVItemsWithTracking';
    APIPublisher = 'ALV';
    APIVersion = 'v2.0';
    APIGroup = 'ALVAPI';
    EntityName = 'ALVItem';
    EntitySetName = 'ALVItems';
    SourceTable = "Item";
    DelayedInsert = true;
    ChangeTrackingAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("No"; "No.")
                {
                    Caption = 'No';
                    ApplicationArea = All;
                }
                field("Description"; Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }

                field("UnitPrice"; "Unit Price")
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                }

                field("ItemCategoryId"; "Item Category Id")
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                }
                field("Picture"; "Picture")
                {
                    Caption = 'Picture';
                    ApplicationArea = All;
                }

            }
        }
    }

}
