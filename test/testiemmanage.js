const ItemManager = artifacts.require("./ItemManager.sol");

contract("ItemManagerTest1", accounts => {
    it("... should be abel to add an item", async function() {
        const itemManagerInstance = await ItemManager.deployed();
        const itemname = "test1";
        const itemPrice = 500;
        const result = await itemManagerInstance.createItem(itemname, itemPrice, {from: accounts[0]})
        // console.log(result);
        assert.equal(result.logs[0].args._itemIndex, 0, "must be zero");
        const item = await itemManagerInstance.items(0);
        // console.log(item);
        assert.equal(item._identifier, itemname, "wrong identifier");
        
    })
})