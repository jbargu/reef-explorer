import {AccountBody, EventBody,} from '../crawler/types';
import {insert} from '../utils/connector';

const toEventValue = async ({
  id,
  blockId,
  extrinsicId,
  index,
  event: {
    event: { method, section, data },
    phase,
  },
  timestamp,
}: EventBody): Promise<string> => {
  return `(${id}, ${blockId}, ${extrinsicId}, ${index}, '${section}', '${method}', '${data}', '${JSON.stringify(phase)}', '${timestamp}')`;
};

export const insertEvents = async (events: EventBody[]): Promise<void> => {
  if (events.length > 0) {
    await insert(`
INSERT INTO event
  (id, block_id, extrinsic_id, index, section, method, data, phase, timestamp)
VALUES
  ${(await Promise.all(events.map(toEventValue))).join(',\n')};
`);
  // await Promise.all(events.map((e:EventBody)=>insertEvmEvent({id:e.id, timestamp: e.timestamp, data: e.event.event.data, section: e.event.event.section, method: e.event.event.method })));
  }
};

export const insertEvent = async (event: EventBody) => insertEvents([event]);

const accountToInsertValue = ({
  address,
  evmAddress,
  blockId,
  active,
  freeBalance,
  availableBalance,
  lockedBalance,
  reservedBalance,
  votingBalance,
  vestedBalance,
  identity,
  nonce,
  evmNonce,
  timestamp,
}: AccountBody): string => `
  ('${address}', '${evmAddress}', ${blockId}, ${active}, ${freeBalance}, ${lockedBalance}, ${availableBalance}, ${reservedBalance}, ${votingBalance}, ${vestedBalance}, '${identity}', ${nonce}, ${evmNonce}, '${timestamp}')`;

export const insertAccounts = async (
  accounts: AccountBody[],
): Promise<void> => {
  if (accounts.length > 0) {
    await insert(`
INSERT INTO account
  (address, evm_address, block_id, active, free_balance, locked_balance, available_balance, reserved_balance, voting_balance, vested_balance, identity, nonce, evm_nonce, timestamp)
VALUES
  ${accounts.map(accountToInsertValue).join(',')}
ON CONFLICT (address) DO UPDATE SET
  active = EXCLUDED.active,
  block_id = EXCLUDED.block_id,
  evm_address = EXCLUDED.evm_address,
  free_balance = EXCLUDED.free_balance,
  locked_balance = EXCLUDED.locked_balance,
  vested_balance = EXCLUDED.vested_balance,
  voting_balance = EXCLUDED.voting_balance,
  reserved_balance = EXCLUDED.reserved_balance,
  available_balance = EXCLUDED.available_balance,
  timestamp = EXCLUDED.timestamp,
  nonce = EXCLUDED.nonce,
  evm_nonce = EXCLUDED.evm_nonce,
  identity = EXCLUDED.identity;
`);
  }
};
