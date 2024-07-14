/*
 * Factory.cpp
 *
 * Copyright 2023 Matthew Ballance and Contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may 
 * not use this file except in compliance with the License.  
 * You may obtain a copy of the License at:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, 
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
 * See the License for the specific language governing permissions and 
 * limitations under the License.
 *
 * Created on:
 *     Author:
 */
#include "jit/cc/FactoryExt.h"
#include "Factory.h"
#include "TinyCC.h"


namespace jit {
namespace cc {


Factory::Factory() {

}

Factory::~Factory() {

}

void Factory::init(dmgr::IDebugMgr *dmgr) {
    m_dmgr = dmgr;
}

IJitCC *Factory::mkTinyCC() {
    return new TinyCC(m_dmgr);
}

Factory *Factory::inst() {
    if (!m_inst) {
        m_inst = std::unique_ptr<Factory>(new Factory());
    }
    return m_inst.get();
};

}
}

extern "C" jit::cc::IFactory *jit_cc_getFactory() {
    return jit::cc::Factory::inst();
}