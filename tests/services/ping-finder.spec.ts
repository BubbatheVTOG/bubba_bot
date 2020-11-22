import "reflect-metadata";
import 'mocha';
import {expect} from 'chai';
import {PingFinder} from "../../src/services/ping-finder";

describe('PingFinder', () => {
  let service: PingFinder;
  beforeEach(() => {
    service = new PingFinder();
  })

  it('should find "ping" in the string', () => {
    expect(service.isPing("ping")).to.be.true
  })
});
