page 70759924 "ALV ItemsWithTracking"
{
    PageType = API;
    Caption = 'ALVItemsWithTracking';
    APIPublisher = 'VRP';
    APIVersion = 'v2.0';
    APIGroup = 'ALV';
    EntityName = 'APP365ALVItem';
    EntitySetName = 'APP365ALVItems';
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
