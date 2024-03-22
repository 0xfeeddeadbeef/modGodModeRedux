class KeyBinderNew extends CPlayer
{
    function InitNew()
    {
        theInput.RegisterListener(this, 'OnMoney1', 'Money1');
        theInput.RegisterListener(this, 'OnMoney2', 'Money2');
        theInput.RegisterListener(this, 'OnMoney3', 'Money3');
        theInput.RegisterListener(this, 'OnMoney4', 'Money4');
    }

    private function godModeRepairItem(inv : CInventoryComponent, item : SItemUniqueId)
    {
        inv.SetItemDurabilityScript(item, inv.GetItemMaxDurability(item));
    }

    private function godModeRepairAllItems( inv : CInventoryComponent )
    {
        var items : array<SItemUniqueId>;
        var i     : int;

        inv.GetAllItems(items);

        for (i = 0; i < items.Size(); i += 1)
        {
            if (godModeCanRepairItem(inv, items[i]))
            {
                if (inv.HasItemDurability(items[i]))
                {
                    if (inv.GetItemDurability(items[i]) < inv.GetItemMaxDurability(items[i]))
                    {
                        godModeRepairItem(inv, items[i]);
                    }
                }
            }
        }
    }

    private function godModeCanRepairItem(inv : CInventoryComponent, item : SItemUniqueId) : bool
    {
        if (inv.IsItemAnyArmor(item) ||
           (inv.IsItemSteelSwordUsableByPlayer(item) || inv.IsItemSilverSwordUsableByPlayer(item) || inv.IsItemSecondaryWeapon(item)))
        {
            return true;
        }

        return false;
    }

    private function godModeEnrichInventory(inv : CInventoryComponent) : bool
    {
        if (inv)
        {
            inv.AddAnItem('Crowns', 5000, true, true, false);
            //inv.AddAnItem('White Gull 1', 1, true, false, false);
            //inv.AddAnItem('Clearing Potion', 1, true, false, false);
            //inv.AddAnItem('Doppler mutagen', 1, true, false, false);
            //inv.AddAnItem('Ancient Leshy mutagen', 1, true, false, false);
            //inv.AddAnItem('Succubus mutagen', 1, true, false, false);
            //inv.AddAnItem('Troll mutagen', 1, true, false, false);
            //inv.AddAnItem('White Gull 1', 1, true, false, false);
            //inv.AddAnItem('Nightwraith dark essence', 1, true, false, false);

            return true;
        }

        return false;
    }

    event OnMoney1(action : SInputAction)
    {
        var inv : CInventoryComponent;

        if (IsPressed(action))
        {
            inv = GetWitcherPlayer().inv;
            godModeEnrichInventory(inv);
            theGame.GetGuiManager().ShowNotification("Enriched");
        }
    }

    event OnMoney2(action : SInputAction)
    {
        var inv : CInventoryComponent;

        if (IsPressed(action))
        {
            inv = GetWitcherPlayer().inv;
            //GetWitcherPlayer().AddRepairObjectBuff(true, true);
            godModeRepairAllItems(inv);
            theGame.GetGuiManager().ShowNotification("Repaired");
        }
    }

    event OnMoney3(action : SInputAction)
    {
        if (IsPressed(action))
        {
            GetWitcherPlayer().AddRepairObjectBuff(true, true);
            theGame.GetGuiManager().ShowNotification("Enhanced");
        }
    }

    event OnMoney4(action : SInputAction)
    {
        var player : CPlayer;

        if (IsPressed(action))
        {
            if (!thePlayer)
                player = GetWitcherPlayer();
            else
                player = thePlayer;

            player.GainStat(BCS_Stamina, player.GetStatMax(BCS_Stamina));
            player.GainStat(BCS_Vitality, player.GetStatMax(BCS_Vitality));

            player.ForceSetStat(BCS_Toxicity, 0);
            player.ForceSetStat(BCS_Focus, 3);

            theGame.GetGuiManager().ShowNotification("Rejuvenated");
        }
    }
}
