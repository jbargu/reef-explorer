-- SELECT * FROM extrinsic;

-- INSERT INTO extrinsic
--     (block_id, index, hash, args, docs, method, section, signed, type)
--   VALUES
--     (1, 0, '0xcafeca39414f2df71b88f363604c730d9fe78e54d08daee52ec15d394d7576d7', '[1620874260004]', '["Set weight>"]', 'set', 'timestamp', '5C4hrfjw9DjXZTzV3MwzrrAr9P1MJhSrvWGWqi1eSuyUpnhM', 'unsigned');


-- CREATE TABLE IF NOT EXISTS transfer (
--   id BIGSERIAL,
--   block_id BIGINT,
--   extrinsic_id BIGINT,

--   denom TEXT NOT NULL,
--   to_address VARCHAR NOT NULL,
--   from_address VARCHAR NOT NULL,
--   amount NUMERIC(80,0) NOT NULL,
--   fee_amount NUMERIC(80, 0) NOT NULL,

--   error_message TEXT,
--   success BOOLEAN NOT NULL,

--   timestamp timestamp default current_timestamp,

--   PRIMARY KEY (id),
--   CONSTRAINT fk_block
--     FOREIGN KEY(block_id)
--       REFERENCES block(id),
--   CONSTRAINT fk_extrinsic
--     FOREIGN KEY(extrinsic_id)
--       REFERENCES extrinsic(id)
-- );

  -- INSERT INTO transfer
  --   (block_id, extrinsic_id, denom, to_address, from_address, amount, fee_amount, success, error_message)
  -- VALUES
  --   (2240, 4, 'REEF', '5DvcwghWVZW9BueQ1RzHYcosrKUX6tbbMPhnYGv6XdjMmubF', '5EWQoe6as356KHLBsTYKKeTVVJ22PdfPrCCAQWP4wT9Wwjcc', 10000000000000000000000, 10000000000000000000000, 'true', '');

--   CREATE TABLE IF NOT EXISTS transfer (
--   id BIGSERIAL,
--   block_id BIGINT,
--   extrinsic_id BIGINT,

--   denom TEXT NOT NULL,
--   to_address VARCHAR NOT NULL,
--   from_address VARCHAR NOT NULL,
--   amount NUMERIC(80,0) NOT NULL,
--   fee_amount NUMERIC(80, 0) NOT NULL,

--   error_message TEXT,
--   success BOOLEAN NOT NULL,

--   timestamp timestamp default current_timestamp,

--   PRIMARY KEY (id),
--   CONSTRAINT fk_block
--     FOREIGN KEY(block_id)
--       REFERENCES block(id),
--   CONSTRAINT fk_extrinsic
--     FOREIGN KEY(extrinsic_id)
--       REFERENCES extrinsic(id)
-- );
-- SELECT * FROM block ORDER BY id DESC LIMIT 10;
-- SELECT * FROM unverified_evm_call;
-- SELECT * from contract;

-- delete from block where id >= 47136;

-- select * from block where id > 1573459;


-- delete from unverified_evm_call where extrinsic_id >= 1334224;
-- delete from contract where extrinsic_id >= 1334224;
-- delete from account where extrinsic_id >= 1334224;
-- delete from transfer where extrinsic_id >= 1334224;
-- delete from event where extrinsic_id >= 1334224;
-- delete from extrinsic where id >= 1334224;

-- SELECT id from extrinsic where block_id = 1114016;

-- ALTER TABLE transfer
-- DROP CONSTRAINT fk_from_address,
-- ADD CONSTRAINT fk_from_address
--   FOREIGN KEY (from_address)
--   REFERENCES account (address)
--   ON DELETE CASCADE;

-- ALTER TABLE unverified_evm_call
-- DROP CONSTRAINT fk_account,
-- ADD CONSTRAINT fk_account
--   FOREIGN KEY (signer_address)
--   REFERENCES account (address)
--   ON DELETE CASCADE;

-- ALTER TABLE verification_request
-- DROP CONSTRAINT fk_contract;

-- SELECT * FROM event WHERE section = 'staking';
-- DELETE FROM verified_contract where address not in ('0x0000000000000000000000000000000000000803', '0x0000000000000000000000000000000000000802', '0x0000000000000000000000000000000000000801', '0x0000000000000000000000000000000000000800', '0x0000000000000000000000000000000001000001', '0x0000000000000000000000000000000001000000');
-- DELETE FROM block where id > 0;


SELECT
  ee.id, ee.event_id as eventId, ee.block_id as blockId, ev.extrinsic_id as extrinsicId, ee.event_index as eventIndex, 
  ee.extrinsic_index as extrinsicIndex, ee.contract_address as contractAddress, ee.data_raw as rawData, ee.method,
  ee.type, ee.status, ex.timestamp as timestamp, ex.signed_data as signedData
FROM evm_event as ee
JOIN event as ev
  ON ev.id = ee.event_id
JOIN extrinsic as ex
  ON ev.extrinsic_id = ex.id
WHERE ee.contract_address = '0x0230135fDeD668a3F7894966b14F42E65Da322e4' AND ee.type = 'Unverified';