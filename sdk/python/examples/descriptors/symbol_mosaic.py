from symbolchain.core.facade.SymbolFacade import SymbolFacade
from symbolchain.core.symbol.IdGenerator import generate_mosaic_id


def descriptor_factory():
    sample_address = SymbolFacade.Address('TASYMBOLLK6FSL7GSEMQEAWN7VW55ZSZU2Q2Q5Y')

    return [
        {
            'type': 'mosaic_definition',
            'duration': 1,
            'nonce': 123,
            'flags': 'transferable restrictable',
            'divisibility': 2
        },

        {
            'type': 'mosaic_supply_change',
            'mosaic_id': generate_mosaic_id(sample_address, 123),
            'delta': 1000 * 100,  # assuming divisibility = 2
            'action': 'increase'
        }
    ]